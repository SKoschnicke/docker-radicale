FROM ubuntu:latest
MAINTAINER Sven Koschnicke <sven@koschnicke.de>

# workaround problem with upstart not running
# see https://github.com/dotcloud/docker/issues/1024
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -s /bin/true /sbin/initctl

# update system
RUN echo "deb http://de.archive.ubuntu.com/ubuntu precise main restricted universe multiverse" > /etc/apt/sources.list
RUN echo "deb http://de.archive.ubuntu.com/ubuntu precise-updates main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb http://de.archive.ubuntu.com/ubuntu precise-security main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb http://de.archive.ubuntu.com/ubuntu precise-backports main restricted universe multiverse" >> /etc/apt/sources.list
RUN apt-get update
#RUN apt-get -y upgrade

# install required packages
RUN apt-get -y install radicale

# add radicale config
ADD config /etc/radicale/config

# volume for storing calendar data (but you may want to bind a dir from the host with -v /host/path:/caldata)
VOLUME ["/caldata"]

EXPOSE 5232

CMD /usr/bin/radicale
