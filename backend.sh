#!/bin/bash
userid=$(id -u)
script_name=$(echo $0 | cut -d "." -f1)
time_stamp=$(date +%F-%H-%M-%S)
logfile=/tmp/$script_name-$time_stamp.log
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
echo "please enter mysql password"
read -s my_sql_password

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
fi

dnf module disable nodejs -y &>>$logfile
validate $? "$G sccessfully disabled $N"

dnf module enable nodejs:20 -y &>>$logfile
validate $? "$G enabled nodejs:20 $N"

dnf install nodejs -y &>>$logfile
validate $? "$G installed nodejs:20 $N"

id expense &>>$logfile
if [ $? -ne 0 ]
then
    useradd expense &>>$logfile
    validate $? "$G user expense added $N"
else
    echo -e "$G ***userexpense already present*** $Y ***Skipping*** $N"
fi

mkdir -p /app &>>$logfile

curl -o /tmp/backend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-backend-v2.zip &>>$logfile
validate $? "$Y ***downling backend code*** $N"


cd /app &>>$logfile
rm -rf /app/*
unzip /tmp/backend.zip &>>$logfile
validate $? "$Y ***unzipping backend file*** $N"

cd /app &>>$logfile
npm install &>>$logfile
validate $? "$G ***installing npm*** $N"

cp /home/ec2-user/expense-shell/backend.service  /etc/systemd/system/backend.service &>>$logfile
validate $? "copied backend service"

systemctl daemon-reload &>>$logfile
validate $? "daemon-reload"

systemctl start backend &>>$logfile
validate $? "start backend"

systemctl enable backend &>>$logfile
validate $? "enable backend"


dnf install mysql-server -y &>>$logfile
validate $? "mysql-server"

mysql -h db.daws79s.online -uroot -p${my_sql_password} < /app/schema/backend.sql &>>$logfile
validate $? "loading schema"
#sudo cat /app/schema/backend.sql

systemctl restart backend &>>$logfile
validate $? "restating backend"

#systemctl status backend