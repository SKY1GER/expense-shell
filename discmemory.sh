#!/bin/bash

Files=$(df -hT | grep xfs)
echo "$Files"
Threshold=10
Message=''

 while IFS= read -r line
 do
    echo "$line"
    usage=$(echo $line | awk -F "" '{print $6F}' | cut -d "%" -f1)
    folder=$(echo $line | awk -F "" '{print $NF}')
    echo "$usage $floder"
    if [ $usage -ge $Threshold ]
    then
    Message+="$folder is more than $Threshold, current usage :$usage"
    fi
 done <<< $Files

 echo "Message is : $Message"