FROM centos:centos7.6.1810
RUN cat >> /etc/yum.repos.d/otus.repo << EOF
    [otus] && \
    name=otus-linux && \
    baseurl=http://localhost/repo && \
    gpgcheck=0 && \
    enabled=1 && \
    EOF && \
    yum-config-manager --disable * && \
    yum-config-manager --enable otus && \
    yum install -y nginx
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
EXPOSE 80
CMD [ "nginx" ]
