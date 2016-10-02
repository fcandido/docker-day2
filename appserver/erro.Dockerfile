FROM centos:6.8

RUN yum -y install perl openssh-server sudo crontabs which &&\
	yum clean all && useradd -g wheel monitor &&\
	echo monitor | passwd --stdin monitor  &&\
	mkdir -p /var/log/supervisor /opt/scritps/monitor &&\
        chown monitor:wheel /opt/scritps/monitor
ADD monitor /var/spool/cron/monitor
ADD mcacheconnect /usr/bin/mcacheconnect
RUN echo "monitor   (ALL) = ALL" >> /etc/sudoers
RUN touch /var/log/cron


EXPOSE 22
CMD ["/etc/init.d/sshd", "start"] 
CMD ["/etc/init.d/rsyslog", "start"] 
CMD ["/etc/init.d/crond", "start"] 
CMD ["tail", "-f", "/var/log/cron"]
