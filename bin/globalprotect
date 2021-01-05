#!/bin/bash

case $# in
   0)
      echo "Usage: $0 {start|stop}"
      exit 1
      ;;
   1)
      case $1 in
         start)
            echo "Starting GlobalProtect..."
            launchctl load /Library/LaunchAgents/com.paloaltonetworks.gp.pangpa.plist
            launchctl load /Library/LaunchAgents/com.paloaltonetworks.gp.pangps.plist
            echo "Done!"
            ;;
         stop)
            echo "Stopping GlobalProtect..."
            launchctl remove com.paloaltonetworks.gp.pangps
            launchctl remove com.paloaltonetworks.gp.pangpa
            echo "Done!"
            ;;
         *)
            echo "'$1' is not a valid verb."
            echo "Usage: $0 {start|stop}"
            exit 2
            ;;
      esac
      ;;
   *)
      echo "Too many args provided ($#)."
      echo "Usage: $0 {start|stop}"
      exit 3
      ;;
esac
