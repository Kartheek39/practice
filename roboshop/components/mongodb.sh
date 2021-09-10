#!/bin/bash
echo "setting mongodb repository"
echo '[mongodb-org-4.2]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/4.2/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-4.2.asc' >/etc/yum.repos.d/mongodb.repo
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"]
else
  echo -e "\e[31mFAILURE\e[0m"]
  exit 2
fi
echo "installing mongodb"
yum install -y mongodb-org &>>/tmp/log
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"]
else
  echo -e "\e[31mFAILURE\e[0m"]
  exit 2
fi
echo "starting mongodb"
systemctl enablee mongod
systemctl start mongod
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"]
else
  echo -e "\e[31mFAILURE\e[0m"]
  exit 2
fi

echo "configuring mongodb"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
systemctl restart mongod
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"]
else
  echo -e "\e[31mFAILURE\e[0m"]
  exit 2
fi
echo "downloading schema "
curl -s -L -o /tmp/mongodb.zip "https://github.com/roboshop-devops-project/mongodb/archive/main.zip"
cd /tmp
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"]
else
  echo -e "\e[31mFAILURE\e[0m"]
  exit 2
fi
echo "extracting archive schema file"
unzip -o mongodb.zip &>>/tmp/log
cd mongodb-main
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"]
else
  echo -e "\e[31mFAILURE\e[0m"]
  exit 2
fi
echo "loading schema to mongodb"
mongo < catalogue.js &>>/tmp/log
mongo < users.js &>>/tmp/log
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"]
else
  echo -e "\e[31mFAILURE\e[0m"]
  exit 2
fi
