#!/bin/bash
yum install docker -y
systemctl enable docker
systemctl start docker
docker build /vagrant/ -t zhvakinde/dz10_nginx:v1
docker run -d -p 8080:80  zhvakinde/dz10_nginx:v1
