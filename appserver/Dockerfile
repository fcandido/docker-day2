FROM centos:6.8

MAINTAINER FC <fabricio.candido@gmail.com>
LABEL Description="Example container generating data for memcached"

RUN 	yum -y update &&\
	yum -y install	perl \ 
			python-setuptools \
			openssh-server \
			sudo \
			crontabs \
			which \
			git &&\
	easy_install supervisor &&\
	yum clean all &&\
	useradd -g wheel monitor &&\
	echo monitor | passwd --stdin monitor  &&\
	mkdir -p /var/log/supervisor /opt/scripts/monitoring /tmp/applogs &&\
        touch /var/log/cron &&\
        chown monitor:wheel /opt/scripts/monitoring /tmp/applogs &&\
	echo "monitor   ALL=(ALL)       ALL" >> /etc/sudoers
ADD monitor /var/spool/cron/monitor
ADD mcacheconnect /usr/bin/mcacheconnect
ADD supervisord.conf /etc/supervisord.conf
COPY monitoring /opt/scripts/monitoring

EXPOSE 22
CMD ["/usr/bin/supervisord"]
