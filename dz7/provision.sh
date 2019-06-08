#!/bin/bash

#1 задание
cp /vagrant/watchlog /etc/sysconfig/
cp /vagrant/watchlog.log /var/log/
cp /vagrant/watchlog.sh /opt/ 
cp /vagrant/watchlog.service /etc/systemd/system/
cp /vagrant/watchlog.timer /etc/systemd/system/
chmod +x /opt/watchlog.sh

systemctl daemon-reload
systemctl enable watchlog.timer
systemctl enable watchlog.service
systemctl start watchlog.timer
systemctl start watchlog.service

#2 задание
yum install epel-release -y && yum install spawn-fcgi php php-cli mod_fcgid httpd -y

sed -i 's/#SOCKET/SOCKET/' /etc/sysconfig/spawn-fcgi
sed -i 's/#OPTIONS/OPTIONS/' /etc/sysconfig/spawn-fcgi

cp /vagrant/spawn-fcgi.service /etc/systemd/system/spawn-fcgi.service

systemctl daemon-reload
systemctl enable spawn-fcgi
systemctl start spawn-fcgi

#3 задание
