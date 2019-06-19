#!/bin/bash
yum install docker -y
systemctl enable docker
systemctl start docker
docker build /vagrant/ -t nginx:v1
docker run -p 8080:80 -dit nginx:v1
