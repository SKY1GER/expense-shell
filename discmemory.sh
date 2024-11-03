#!/bin/bash

Files=$(df -hT | grep xfs)
Threshold=10
Message=''

 while IFS= read -r line
 do
 usage=$($line | awk -F "" '{print 6F}')
 folder=$($line | awk -F "" '{print NF}')
 if [ $usage -ge $Threshold]
 then
    Message+="$folder is more than $Threshold, current usage :$usage"
 else
    echo "$folder is in range ofd $Threshold, current usage :$usage
 fi
 done <<<$Files

 echo "Message is : $Message"