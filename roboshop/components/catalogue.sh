#!/bin/bash
source components/common.sh
print "installing nodejs\t\t"
yum install nodejs make gcc-c++ -y &>>$LOG
status_check $?
print "adding user\t\t\t"
id roboshop &>>$LOG
if [ $? -eq 0 ]; then
    echo "user already exit. so skipping" &>>$LOG
else 
    useradd roboshop
fi
status_check $?
print "downloading catalogue file\t"
curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip"
status_check $?
print "redirecting to roboshop directory"
cd /home/roboshop
status_check $?
print "extracting catalogue archieved file"
rm -rf catalogue
unzip -o /tmp/catalogue.zip &>>$LOG
mv catalogue-main catalogue
status_check $?
print "installing npm\t\t\t"
cd /home/roboshop/catalogue 
npm install --unsafe-perm  &>>$LOG
status_check $?
chown roboshop:roboshop -R /home/roboshop
print "setting systemd service\t\t"
sed -i -e 's/MONGO_DNSNAME/mongodb.roboshop.internal/' /home/roboshop/catalogue/systemd.service
status_check $?
print "starting catalogue services\t"
mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service
systemctl daemon-reload
systemctl start catalogue
systemctl enable catalogue
status_check $?