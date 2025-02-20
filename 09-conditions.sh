#!/bin/bash

echo "Enter the Number you want"
read NUMBER
echo "Entered number is $NUMBER"

if [ $NUMBER -le 100 ]      # -lt, -gt, -le, -ge, -eq
then
    echo "$NUMBER is less than or equal to 100"
else
    echo "$NUMBER is greater than 100"
fi