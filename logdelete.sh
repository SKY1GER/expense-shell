#!/bin/bash

SOURCEDIRECTORY=/tmp/app-logs

R="\e[31m"
G="\e[32m"
Y="\e[32m"
N="\e[0m"

if [ -d $SOURCEDIRECTORY ]
then
    echo -e "$G $SOURCEDIRECTORY exists $N"
else
    echo -e "$R $SOURCEDIRECTORY not exist $R"
    exit 1
fi

filestobedeleted=$(find $SOURCEDIRECTORY -name "*.log" -mtime +09)

echo -e"$R files to be deleted $filestobedeleted $N"

while IFS=read -r line
do
echo -e "$R file to be deleted:$line"
rm -rf $line
done <<< $filestobedeleted
    