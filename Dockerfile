FROM ubuntu:12.10
MAINTAINER John Fink <john.fink@gmail.com>
RUN apt-get update # Thu Nov  7 22:40:44 EST 2013
# RUN apt-get -y upgrade
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install openssh-server mysql-client mysql-server apache2 libapache2-mod-php5 pwgen python-setuptools  supervisor php5-mysql
# RUN easy_install supervisor
run     mkdir -p /var/run/sshd
run     mkdir -p /var/log/supervisor
run     /bin/sh -c 'echo root:testpass | chpasswd'
ADD ./start.sh /start.sh
ADD ./foreground.sh /etc/apache2/foreground.sh
add ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN chmod 755 /start.sh
RUN chmod 755 /etc/apache2/foreground.sh
EXPOSE 80 22
CMD ["/bin/bash", "/start.sh"]
