#!/bin/bash
source components/common.sh
print "setting mongodb repository"
echo '[mongodb-org-4.2]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/4.2/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-4.2.asc' >/etc/yum.repos.d/mongodb.repo
status_check $?
print "installing mongodb\t"
yum install -y mongodb-org &>>/tmp/log
status_check $?
print "starting mongodb\t"
systemctl enable mongod
systemctl start mongod
status_check $?
print "configuring mongodb\t"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
systemctl restart mongod
status_check $?
print "downloading schema\t"
curl -s -L -o /tmp/mongodb.zip "https://github.com/roboshop-devops-project/mongodb/archive/main.zip"
cd /tmp
status_check $?
print "extracting archive schema file"
unzip -o mongodb.zip &>>/tmp/log
cd mongodb-main
status_check $?
print "loading schema to mongodb"
mongo < catalogue.js &>>/tmp/log
mongo < users.js &>>/tmp/log
status_check $?
