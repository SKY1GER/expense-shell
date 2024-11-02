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
    