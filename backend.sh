#!/bin/bash
userid=$(id -u)
script_name=$(echo $0 | cut -d "." -f1)
time_stamp=$(date +%F-%H-%M-%S)
logfile=/tmp/$script_name-$time_stamp.log
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

validate(){
if [ $1 -ne 0 ]
then
    echo -e "$R $2 ***Installation Failure***"
    exit 1
else
    echo -e "$G $2 ***Installation Success***"
fi    
}

if [ $userid -ne 0 ]
then
    echo "please run script as super user"
    exit
else
    echo "you are a super user"

dnf module disable nodejs -y &>>$logfile
validate $? "$Y sccessfully disabled $N"

dnf module enable nodejs:20 -y &>>$logfile
validate $? "$Y enabled nodejs:20 $N"

dnf install nodejs -y &>>$logfile
validate $? "$Y installed nodejs:20 $N"

id expense
if [ $? -ne 0 ]
then
    useradd expense &>>$logfile
    validate $? "$G user expense added $N"
else
    echo -e "$G ***userexpense already present*** $N"
fi