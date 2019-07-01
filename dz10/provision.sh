#!/bin/bash
yum install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install -y -q docker-ce docker-ce-cli containerd.io
systemctl enable docker
systemctl start docker
docker build /vagrant/ -t zhvakinde/dz10_nginx:v1
docker run -d -p 8080:80  zhvakinde/dz10_nginx:v1
# Дополнительное задание
yum install -y epel-release
yum install -y python-pip
pip install --upgrade pip
pip install docker-compose
