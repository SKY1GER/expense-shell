#!/bin/bash

set -e

handle_error(){
   echo "error occured at line no. $1 : error comand is $2"
}
trap "handle_error ${LINENO} "$BASH_COMMAND"' ERR

source ./common.sh

check_root

echo "please enter mysql password"
read -s my_sql_password

dnf install rfyhyvg -y &>>$logfile #script will exit here because of set -e
