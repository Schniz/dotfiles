#!/bin/bash

# Invoke like this:
# ./watch.sh my command here
# And it will run 'my command here' once, and then when it detects changes.

# TODO: Don't just search in the last second. Search for updates since the last
# completed build. Otherwise for big directories, midway through your search
# you've already taken 1s and you will miss updates.

COUNT=1
FILE_SET=""
daemon() {
    while true
    do
      COUNT=$((COUNT-1))
      DID_BUILD_BECAUSE_FILE_SET="false"
      if [ $COUNT == 0 ]; then
        # This command has no mtime flag. It gets the whole set.
        NEW_FILE_SET=$(find . -path \*/.git -prune -o -path \*/.hg -prune -o -path \*/node_modules -prune -o -path -prune -o -path \*/_build -prune -o -not -name \*.merlin -type f -name "*" -print)
        # This will trigger our initial build.
        if [ "${FILE_SET}" != "${NEW_FILE_SET}" ]; then
          # Don't print the file diffs for the first build.
          echo ""
          echo "[WATCH] Rebuilding Because Tracked File Set Changed:"
          diff  <(echo "$FILE_SET" ) <(echo "$NEW_FILE_SET")
          echo ""
          echo ""
          FILE_SET="${NEW_FILE_SET}"
          eval "$@"
          echo ""
          echo "[WATCH] Done Running Command:" "$@"
          echo ""
          DID_BUILD_BECAUSE_FILE_SET="true"
        fi
        COUNT=10
      fi
      # Already built due to finding a removed/new file. No need to build again.
      if [ "$DID_BUILD_BECAUSE_FILE_SET" != "true" ]; then
        # Find commands are like:
        # prune-command-that-evaluates-to-true -or another-prune-command -or actual-find-command print-or-exec
        # prune commands look like actual find commands followed by a -prune
        # You should always include a final print or exec to avoid parsing ambiguity!
        # https://stackoverflow.com/questions/1489277/how-to-use-prune-option-of-find-in-sh

        if [[ "$OSTYPE" == "linux-gnu" || "$OSTYPE" == "cygwin"  ]]; then
          # .016 is how you do -mtime -1s on linux.
          CHANGED_FILES=$(find . -path \*/.git -prune -o -path \*/.hg -prune -o -path \*/node_modules -prune -o -path -prune -o -path \*/_build -prune -o -not -name \*.merlin -type f  -mmin .016 -name "*" -print)
        elif [[ "$OSTYPE" == "darwin"* ]]; then
          CHANGED_FILES=$(find . -path \*/.git -prune -o -path \*/.hg -prune -o -path \*/node_modules -prune -o -path -prune -o -path \*/_build -prune -o -not -name \*.merlin -type f  -mtime -1s -name "*" -print)
        else
          echo "Unsupported Operating System: ${OSTYPE}"
        fi

        if [[ "$CHANGED_FILES" == "" ]]; then
          # Then nothing change in last -mtime. -mtime only reports files that have changed.
          true
        else
          echo ""
          echo "[WATCH] Rebuilding Due To File Changes:"
          echo "$CHANGED_FILES"
          echo ""
          echo ""
          echo "[WATCH] Running Command:" "$@"
          eval "$@"
          echo ""
          echo "[WATCH] Done Running Command:" "$@"
          echo ""
        fi
      fi
      sleep 0.6
    done
}

daemon "$@"