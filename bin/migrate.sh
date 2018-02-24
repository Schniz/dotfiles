#!/bin/bash
# Runs migrations on PostgreSQL

set -e

function make_new_migration() {
  FILE_DESC=$(echo $@ | sed -E "s/[[:space:]]+/_/g" | awk '{print tolower($0)}')
  FILE_PATH=db/migrations/$(get_timestamp)_${FILE_DESC}.sql
  mkdir -p db/migrations
  touch $FILE_PATH
  echo "  --> touched $FILE_PATH"
}

function verify_database_url() {
  if [ "$DATABASE_URL" == "" ]; then
    echo "  --> ERROR: variable DATABASE_URL is not defined"
    exit 1
  fi
}

function pending_migrations() {
  UP_MIGRATIONS=$(bash -c 'psql $DATABASE_URL -t -c "select filename from migrations" | sed "s@[[:space:]]@@g" | grep . | cat' 2> /dev/null)
  ALL_MIGRATIONS=$(bash -c 'cd db/migrations && ls *.sql')
  STRINGIFIED_MIGRATIONS=" ${ALL_MIGRATIONS[*]} "
  for item in ${UP_MIGRATIONS[@]}; do
    STRINGIFIED_MIGRATIONS=${STRINGIFIED_MIGRATIONS/${item}/ }
  done
  MIGRATIONS_TO_RUN=( $STRINGIFIED_MIGRATIONS )
  for item in ${MIGRATIONS_TO_RUN[@]}; do
    echo $item
  done
}

function run_migrations() {
  PENDING_MIGRATIONS=$(pending_migrations)
  if [ "$PENDING_MIGRATIONS" == "" ]; then
    echo "  --> Nothing to migrate!"
  else
    echo "PENDING MIGRATIONS:"
    echo ${PENDING_MIGRATIONS[*]}
    echo "==================="
    for PENDING_MIGRATION in $PENDING_MIGRATIONS; do
      CONTENTS=$(cat db/migrations/$PENDING_MIGRATION)
      CONTENTS_WITH_MIGRATION_RESULT="begin; $CONTENTS; insert into migrations (filename) values ('$(basename $PENDING_MIGRATION)'); commit;"
      echo "  --> Running $PENDING_MIGRATION"
      cat <<< "$CONTENTS_WITH_MIGRATION_RESULT"
      psql $DATABASE_URL 1>/dev/null <<< $CONTENTS_WITH_MIGRATION_RESULT
    done
  fi
  dump_schema
}

function dump_schema() {
  mkdir -p db

  pg_dump \
    --schema-only \
    $DATABASE_URL \
    > db/schema.sql.tmp
  pg_dump \
    --data-only \
    -t migrations \
    $DATABASE_URL \
    >> db/schema.sql.tmp
 
  cat db/schema.sql.tmp | grep -v -e "---\?\( .\+\)\$" | grep -v -e "^--\$" | grep -v -e "^\$" > db/schema.sql
  rm db/schema.sql.tmp

  echo "  --> Wrote db/schema.sql"
}

function reset_db() {
  psql $DATABASE_URL <<< "
    drop schema public cascade;
    create schema public;
  "
}

function show_help() {
  echo "Usage:"
  echo "------"
  echo ""
  echo "$0 new add_something_table - create a new migration file"
  echo "$0 schema:dump             - dump db schema"
  echo "$0 schema:load             - load db schema"
  echo "$0 up                      - run migrations"
  echo "$0 danger:reset            - resets the database state"
  echo "$0 help                    - show this message"
}

function get_timestamp() {
  date +%Y%m%d%H%M%S
}

function main_migrate() {
  ACTION=${1-:"help"}
  shift
  case $ACTION in
    new)
      make_new_migration $@
      ;;
    schema:dump)
      verify_database_url
      dump_schema $@
      ;;
    schema:load)
      verify_database_url
      psql $DATABASE_URL -f db/schema.sql
      ;;
    danger:reset)
      verify_database_url
      reset_db
      ;;
    up)
      verify_database_url
      run_migrations $@
      ;;
    *)
      show_help
      exit 1
  esac
}

main_migrate $@
