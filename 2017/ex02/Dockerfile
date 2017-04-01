



FROM ubuntu
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update -y && apt-get install -y language-pack-en libxml2-dev curl python make gcc wget sqlite3 \
    postgresql-client-9.1 postgresql-client-common 

ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
RUN locale-gen  en_US.UTF-8 && dpkg-reconfigure locales

RUN wget https://bootstrap.pypa.io/ez_setup.py
RUN python ez_setup.py
RUN wget https://bootstrap.pypa.io/get-pip.py
RUN python get-pip.py

ADD Dockerfile /opt/Dockerfile.add
COPY Dockerfile /opt/Dockerfile.copy
