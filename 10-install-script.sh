#!/bin/bash

USERID=$(id -u)
if [ $USERID -ne 0 ]
then
    echo "ERROR:: you must have sudo access to execute this script"
    exit 1      #Other than 0
fi

dnf list installed mysql    # checking installed or not

if  [ $? -ne 0 ]     # checking installed or not
then
    dnf install mysql -y

    if [ $? -ne 0 ]     # '$?' means checking previous command status success or not if it is '0' success. Otherwise failure
    then
        echo "Installing MySQL ... FAILURE"
        exit 1
    else
        echo "Installing MySQL ... SUCCESS"
    fi
else
    echo "MySQL is already ... INSTALLED"
fi

dnf list installed git  # checking installed or not

if [ $? -ne 0 ]     # checking installed or not
then
    dnf install git -y

    if [ $? -ne 0 ]
    then
        echo "Installing Git ... FAILURE"
    else
        echo "Installing Git ... SUCCESS"
    fi
else
    echo "Git is already ... INSTALLED"
fi