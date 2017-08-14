#!/bin/bash

export $(egrep -v '^#' ~/dotfiles/bitbar/.env | xargs)
OPEN_ISSUES=$(curl --silent "$JIRA_BASE_URL/rest/api/2/search?jql=assignee+%3D+currentUser()+AND+resolution+%3D+Unresolved+order+by+updated+DESC&fields=*none&maxResults=0" -u "$JIRA_USERNAME:$JIRA_PASSWORD" | /usr/local/bin/jq '.total')
echo "Open Issues: $OPEN_ISSUES"
