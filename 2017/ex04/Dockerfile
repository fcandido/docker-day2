
FROM ubuntu
LABEL version=3.1415

RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list && \
    apt-get update -y && apt-get install -y nginx && \
    echo "daemon off;" >> /etc/nginx/nginx.conf

ADD index.html /usr/share/nginx/www/index.html

EXPOSE 80

ENTRYPOINT ["/usr/sbin/nginx"]

