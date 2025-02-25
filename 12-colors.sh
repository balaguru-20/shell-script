#!/bin/bash

USERID=$(id -u)

R="\e[31m"  #Red
G="\e[32m"  #Green
Y="\e[33m"  #Yellow

VALIDATE(){             #We can write the function anywhere in the program
    if [ $1 -ne 0 ]    
    then
        echo -e "$2 ... $R FAILURE" #-e means enable, $R color cpplying
        exit 1
    else
        echo -e "$2 ... $G SUCCESS"
    fi
}

if [ $USERID -ne 0 ]
then
    echo -e " $R ERROR:: you must have sudo access to execute this script"
    exit 1      #Other than 0
fi

dnf list installed mysql    # checking installed or not

if  [ $? -ne 0 ]     # checking installed or not
then
    dnf install mysql -y
    VALIDATE $? "Installing MySQL"
else
    echo -e "$Y MySQL is already ... INSTALLED"
fi

dnf list installed git  # checking installed or not

if [ $? -ne 0 ]     # checking installed or not
then
    dnf install git -y
    VALIDATE $? "Insatlling Git"
else
    echo -e "$Y Git is already ... INSTALLED"
fi