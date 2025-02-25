#!/bin/bash

USERID=$(id -u)

VALIDATE(){             #We can write the function anywhere in the program
    if [ $1 -ne 0 ]    
    then
        echo "$2 FAILURE"
        exit 1
    else
        echo "$2 SUCCESS"
    fi
}

if [ $USERID -ne 0 ]
then
    echo "ERROR:: you must have sudo access to execute this script"
    exit 1      #Other than 0
fi

dnf list installed mysql    # checking installed or not

if  [ $? -ne 0 ]     # checking installed or not
then
    dnf install mysql -y
    VALIDATE $? "Installing MySQL"
else
    echo "MySQL is already ... INSTALLED"
fi

dnf list installed git  # checking installed or not

if [ $? -ne 0 ]     # checking installed or not
then
    dnf install git -y
    VALIDATE $? "Insatlling Git"
else
    echo "Git is already ... INSTALLED"
fi

