#!/bin/bash

LOGS_FOLDER="/var/log/shellscript-logs"
LOG_FILE=$(echo $0 | cut -d "." -f1 )

echo "$LOGS_FOLDER"
echo "$LOG_FILE"