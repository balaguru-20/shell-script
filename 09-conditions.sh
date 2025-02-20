#!/bin/bash

read NUMBER
echo "Entered number is $NUMBER"

if [ $NUMBER -le 100 ]
then
    echo "$NUMBER is less than or equal to 100"
else
    echo "$NUMBER is greater than 100"
fi