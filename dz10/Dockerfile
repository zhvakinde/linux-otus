FROM alpine:3.9.4
RUN apk add  nginx
RUN mkdir -p /run/nginx/
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
RUN sed -i 44i\ 'root   index.html;' /etc/nginx/nginx.conf
COPY index.html /usr/share/nginx/html
EXPOSE 80
CMD ["nginx"]
