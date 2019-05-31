#!/bin/bash
yum localinstall -y /vagrant/nginx-1.14.1-1.el7_4.ngx.x86_64.rpm
mkdir /usr/share/nginx/html/repo
cp /vagrant/nginx-1.14.1-1.el7_4.ngx.x86_64.rpm /usr/share/nginx/html/repo/
wget http://www.percona.com/downloads/percona-release/redhat/0.1-6/percona-release-0.1-6.noarch.rpm -O /usr/share/nginx/html/repo/percona-release-0.1-6.noarch.rpm
createrepo /usr/share/nginx/html/repo/
sed -i 11i\ 'autoindex on;' /etc/nginx/conf.d/default.conf
sudo -i systemctl start nginx
