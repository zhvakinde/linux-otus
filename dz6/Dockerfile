FROM centos:centos7.6.1810
RUN 
    yum-config-manager --disable * && \
    yum-config-manager --enable otus && \
    yum install -y nginx
EXPOSE 80
