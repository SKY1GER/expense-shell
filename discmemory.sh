#!/bin/bash

Files=$(df -hT | grep xfs)
Threshold=10
Message=''

 while IFS= read -r line
 do
    echo "$line"
    usage=$(echo $line | awk -F " " '{print $6F}' | cut -d "%" -f1 )
    folder=$(echo $line | awk -F " " '{print $NF}' )
    if [ $usage -ge $Threshold ]
    then
        Message+="$folder is more than $Threshold, current usage :$usage\n"
    fi
 done <<< $Files

 echo -e "Message is : $Message"