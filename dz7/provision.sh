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
