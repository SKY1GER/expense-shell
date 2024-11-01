# Hello World Program in Bash Shell

#!/bin/bash
userid=$(id -u)
script_name=$(echo $0 | cut -d "." -f1)
time_stamp=$(date +%F-%H-%M-%S)
logfile=/tmp/$script_name-$time_stamp.log
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e "$2 $R ***installation Failure*** $N"
        exit 1
    else
        echo -e "$2 $G ***installation Success*** $N"
    fi
}

if [ $userid -ne 0 ]
then
    echo "please run in super user"
    exit 1
else
    echo "you are already a super user"
fi

dnf install mysql-server -y &>>$logfile
VALIDATE $? "mysql-server"

systemctl enable mysqld &>>$logfile
VALIDATE $? "enabling mysql-server"

systemctl start mysqld &>>$logfile
VALIDATE $? "staring mysql-server"

mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$logfile
VALIDATE $? "setting up root password for mysql-server"