#!/bin/bash
yum install docker -y
systemctl enable docker
systemctl start docker
