FROM centos:6.8

MAINTAINER FC <fabricio.candido@gmail.com>
LABEL Description="Memcached container"

RUN  	yum -y update &&\ 
	yum -y install	epel-release \
			memcached &&\ 
	yum clean all

EXPOSE  11211

CMD  ["memcached", "-u", "daemon"]
