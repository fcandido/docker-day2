
FROM centos:7

MAINTAINER FC <fabricio.candido@gmail.com>
LABEL Description="Apache container with php support"

RUN	yum -y update &&\
 	yum -y install	httpd \
			python-setuptools \
			php wget &&\
	yum clean all &&\
	echo "<H1>Hello World</H1>" > /var/www/html/index.html

CMD ["-D FOREGROUND"]

ENTRYPOINT ["/usr/sbin/httpd"]





