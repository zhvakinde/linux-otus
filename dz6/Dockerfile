FROM centos:centos7.6.1810
RUN touch /etc/yum.repos.d/otus.repo && \
    echo "[otus]" > /etc/yum.repos.d/otus.repo && \
    echo "name=otus-linux" > /etc/yum.repos.d/otus.repo && \
    echo "baseurl=http://192.168.11.101/repo" > /etc/yum.repos.d/otus.repo && \
    echo "gpgcheck=0" > /etc/yum.repos.d/otus.repo && \
    echo "enabled=1" >  /etc/yum.repos.d/otus.repo && \
    yum-config-manager --disable * && \
    yum-config-manager --enable otus && \
    yum install -y nginx
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
EXPOSE 80
CMD [ "nginx" ]
