#!/bin/bash

USERID=$(id -u)

R="\e[31m"  #Red
G="\e[32m"  #Green
Y="\e[33m"  #Yellow
N="\e[0m"

LOGS_FOLDER="/var/log/shellscript-logs"
LOG_FILE=$(echo $0 | cut -d "." -f1 )
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE_NAME="$LOGS_FOLDER/$LOG_FILE-$TIMESTAMP.log"

VALIDATE(){             #We can write the function anywhere in the program
    if [ $1 -ne 0 ]    
    then
        echo -e "$2 ... $R FAILURE" #-e means enable, $R color cpplying
        exit 1
    else
        echo -e "$2 ... $G SUCCESS"
    fi
}

echo "Script started executing at: $TIMESTAMP" &>>$LOG_FILE_NAME

if [ $USERID -ne 0 ]
then
    echo -e " $R ERROR:: you must have sudo access to execute this script"
    exit 1      #Other than 0
fi

dnf list installed mysql  &>>$LOG_FILE_NAME  # checking installed or not

if  [ $? -ne 0 ]     # checking installed or not
then
    dnf install mysql -y &>>$LOG_FILE_NAME
    VALIDATE $? "Installing MySQL"
else
    echo -e "MySQL is already ... $Y INSTALLED"
fi

dnf list installed git &>>$LOG_FILE_NAME # checking installed or not

if [ $? -ne 0 ]     # checking installed or not
then
    dnf install git -y &>>$LOG_FILE_NAME
    VALIDATE $? "Insatlling Git"
else
    echo -e "Git is already ... $Y INSTALLED"
fi