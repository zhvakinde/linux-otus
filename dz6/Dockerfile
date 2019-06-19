FROM centos:centos7.6.1810
RUN 
    yum-config-manager --disable * && \
    yum-config-manager --enable own_rpm_repo && \
    yes | yum install -y nginx
EXPOSE 80
