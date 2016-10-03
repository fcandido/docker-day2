FROM centos:6.8

MAINTAINER FC <fabricio.candido@gmail.com>
LABEL Description="Apache container with php support"

RUN	yum -y update &&\
 	yum -y install	httpd \
			python-setuptools \
			php \
			which \
			git &&\
	easy_install supervisor &&\
	yum clean all &&\
	mkdir -p /var/log/supervisor
COPY phpMemcachedAdmin /var/www/html
ADD supervisord.conf /etc/supervisord.conf
ADD httpd.conf /etc/httpd/conf/httpd.conf


EXPOSE 80 
CMD ["/usr/bin/supervisord"]
