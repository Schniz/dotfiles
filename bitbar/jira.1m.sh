#!/bin/bash

#
# Install `jq` by `brew install jq`
# Make sure to have ~/dotfiles/bitbar/.env with the following env vars:
# JIRA_USERNAME=...
# JIRA_PASSWORD=...
# JIRA_BASE_URL=https://something.atlassian.net
#

JQ=/usr/local/bin/jq
export $(egrep -v '^#' ~/dotfiles/bitbar/.env | xargs)

JIRA_USER="currentUser()"
ISSUE_DATA=$(curl --silent -u "$JIRA_USERNAME:$JIRA_PASSWORD" "$JIRA_BASE_URL/rest/api/2/search?jql=assignee+%3D+$JIRA_USER+AND+status+!%3D+"Done"+and+status+!=+"Accepted"+order+by+updated+DESC&fields=summary,key&maxResults=5")
ISSUE_NAMES=$(echo $ISSUE_DATA | $JQ "[.issues[] | .fields.summary]" -c -M)
ISSUE_NAMES_LENGTH=$(echo $ISSUE_DATA | $JQ ".issues | length")
OPEN_ISSUES=$(echo $ISSUE_DATA | $JQ '.total')

echo "Open Issues: $OPEN_ISSUES"
echo "---"

if [ $ISSUE_NAMES_LENGTH -gt 0 ]; then
  for x in `seq 0 $((ISSUE_NAMES_LENGTH-1))`; do
    TITLE=$(echo $ISSUE_NAMES | $JQ ".[$x]" -r)
    ISSUE_KEY=$(echo $ISSUE_DATA | $JQ ".issues[$x].key" -r)
    LINK="$JIRA_BASE_URL/browse/$ISSUE_KEY"
    echo "$ISSUE_KEY: $TITLE|length=35 href=$LINK"
  done
fi
