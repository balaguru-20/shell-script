#!bin/bash

DISK_USAGE=$(df -hT | grep xfs)
DISK_THRESHOLD=5 #real projects will monitor for 70%
MSG=""

while read -r line
do
    USAGE=$(echo $line |awk -F " " '{print $6F}' |cut -d "%" -f1)
    PARTITION=$(echo $line | awk -F " " '{print $NF}')
    #echo "Partition: $PARTITION , Usage: $USAGE "
    if [ $USAGE -ge $DISK_THRESHOLD ]
    then
        MSG+="High disk usage on partion: $PARTITION Usage is: $USAGE \n" # before = to '+' means it will append the new lines otherwise it will replace the new lines in the loop
    fi

done <<< $DISK_USAGE

echo -e "Message: $MSG" #-e means it's enables the new line which we mention in the loop MSG variable as \n
echo "guru $PARTITION"