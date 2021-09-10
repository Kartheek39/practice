#!/bin/bash
status_check() {
  if [ $1 -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"]
else
  echo -e "\e[31mFAILURE\e[0m"]
  exit 2
fi
}

echo "setting mongodb repository"
echo '[mongodb-org-4.2]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/4.2/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-4.2.asc' >/etc/yum.repos.d/mongodb.repo
status_check $?
echo "installing mongodb"
yum install -y mongodb-org &>>/tmp/log
status_check $?
echo "starting mongodb"
systemctl enable mongod
systemctl start mongod
status_check $?
echo "configuring mongodb"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
sysemctl restart mongod
status_check $?
echo "downloading schema "
curl -s -L -o /tmp/mongodb.zip "https://github.com/roboshop-devops-project/mongodb/archive/main.zip"
cd /tmp
status_check $?
echo "extracting archive schema file"
unzip -o mongodb.zip &>>/tmp/log
cd mongodb-main
status_check $?
echo "loading schema to mongodb"
mongo < catalogue.js &>>/tmp/log
mongo < users.js &>>/tmp/log
status_check $?
