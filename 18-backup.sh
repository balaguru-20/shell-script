#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14} # This is optional. If the user nt providing number of days, we are taking 14 as default

LOGS_FOLDER="/home/ec2-user/shellscript-logs"
LOG_FILE=$(echo $0 | cut -d "." -f1)
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%s)
LOG_FILE_NAME="$LOGS_FOLDER/$LOG_FILE-$TIMESTAMP.log"

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e "$2 ... $R FAILURE $N"
        exit 1
    else
        echo -e "$2 ... $R SUCCESS $N"
    fi
}

USAGE(){
    echo -e "$R USAGE:: $N sh 18-backup.sh <SOURCE_DIR> <DEST_DIR> <DAYS(optional)>"
    exit 1
}

mkdir -p /home/ec2-user/shellscript-logs

if [ $# -lt 2 ] # $# means how it counts how many args provided
then
    USAGE
fi

if [ ! $SOURCE_DIR ]
then
    echo "$SOURCE_DIR does not exist"
    exit 1
fi

if [ ! $DEST_DIR ]
then
    echo "$DEST_DIR does not exist"
    exit 1
fi

echo "Script started executing at: $TIMESTAMP" &>>$LOG_FILE_NAME

