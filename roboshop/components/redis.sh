#!/bin/bash
source components/common.sh
print "installing utils and download repo"
yum install epel-release yum-utils http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y &>>$LOG
status_check $?
print "settup redis repo\t\t"
yum-config-manager --enable remi &>>$LOG
status_check $?
print "installing redis\t\t"
yum install redis -y &>>$LOG
status_check $?
print "configuring redis ip address\t"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis/redis.conf
status_check $?
print "Starting redis\t\t\t"
systemctl enable redis && systemctl start redis &>>$LOG
status_check $?