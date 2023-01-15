
#! /bin/bash
sudo amazon-linux-extras enable java-openjdk11
sudo yum clean metadata && sudo yum -y install java-11-openjdk
mkdir /home/ec2-user/app3-usermgmt && cd /home/ec2-user/app3-usermgmt
wget https://github.com/stacksimplify/temp1/releases/download/1.0.0/usermgmt-webapp.war -P /home/ec2-user/app3-usermgmt 
export DB_HOSTNAME=${rds_db_endpoint}
export DB_PORT=3306
export DB_NAME=webappdb
export DB_USERNAME=dbadmin
export DB_PASSWORD=dbpassword11
java -jar /home/ec2-user/app3-usermgmt/usermgmt-webapp.war > /home/ec2-user/app3-usermgmt/ums-start.log &