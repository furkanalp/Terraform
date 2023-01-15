#! /bin/bash
yum update -y
rpm -e --nodeps mariadb-libs-*
amazon-linux-extras enable mariadb10.5 
yum clean metadata
yum install -y mariadb
mysql -V
yum install -y telnet