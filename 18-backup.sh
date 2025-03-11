#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14} # This is optional. If the user not providing number of days, we are taking 14 as default

LOGS_FOLDER="/home/ec2-user/shellscript-logs"
LOG_FILE=$(echo $0 | awk -F "/" '{print $NF}' | cut -d "." -f1)
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%s)
LOG_FILE_NAME="$LOGS_FOLDER/$LOG_FILE-$TIMESTAMP.log"

USAGE(){
    echo -e "$R USAGE:: $N sh 18-backup.sh <SOURCE_DIR> <DEST_DIR> <DAYS(optional)>"
    exit 1
}

mkdir -p /home/ec2-user/shellscript-logs

if [ $# -lt 2 ] # $# means it counts how many args are provided
then
    USAGE
fi

if [ ! -d "$SOURCE_DIR" ]
then
    echo "$SOURCE_DIR does not exist ...Please check"
    exit 1
fi

if [ ! -d "$DEST_DIR" ]
then
    echo "$DEST_DIR does not exist ...Please check"
    exit 1
fi

echo "Script started executing at: $TIMESTAMP" &>>$LOG_FILE_NAME

USERID=$(id -u)

CHECK_ROOT(){
    if [ $USERID -ne 0 ]
    then
        echo -e " $R ERROR:: you must have sudo access to install package $N"
        exit 1      #Other than 0
    fi
}

CHECK_ROOT

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e "$2 ...$R FAILURE $N "
    else
        echo -e "$2 ... $G SUCCESS $N"
    fi
}

dnf list installed zip 

if [ $? -ne 0 ]
then
    dnf install zip -y
    VALIDATE $? "Installing zip "
else
    echo -e "ZIP is already installed $Y SKIPPING $N"

fi

FILES=$(find $SOURCE_DIR -name "*.log" -mtime +$DAYS)

if [ -n "$FILES" ] # -n  means not empty. true if there are files to zip
then
    echo "Files are: $FILES"
    ZIP_FILE="$DEST_DIR/app-logs-$TIMESTAMP.zip" #File name creation
    find $SOURCE_DIR -name "*.log" -mtime +$DAYS | zip -@ "$ZIP_FILE"
    if [ -f $ZIP_FILE ] # -f means file
    then
        echo -e "Successfully created zip file for files older then $DAYS"
        while read -r filepath  #Here filepath is the variable name, you can give any name
        do
            echo "Deleting file: $filepath" &>>$LOG_FILE_NAME
            rm -rf $filepath
            echo "Deleted file: $filepath"
        done <<< $FILES   
    else
        echo -e "$R Error:: $N Failed to create ZIP file"
        exit 1
    fi
else
    echo "No files found older than $DAYS"
fi