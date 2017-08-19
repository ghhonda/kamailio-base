FROM ubuntu:16.04

RUN echo "mysql-server mysql-server/root_password password root" | debconf-set-selections
RUN echo "mysql-server mysql-server/root_password_again password root" | debconf-set-selections

RUN apt-get update \
 && apt-get install -y wget
RUN wget -O- http://deb.kamailio.org/kamailiodebkey.gpg | apt-key add -
RUN echo "deb http://deb.kamailio.org/kamailio50 xenial main" >> /etc/apt/sources.list
RUN apt-get update \
 && apt-get install -y mysql-server kamailio kamailio-mysql-modules

RUN echo "[client]" >> /etc/mysql/my.cnf \
 && echo "user=root\npassword=root" >> /etc/mysql/my.cnf

RUN echo "SIP_DOMAIN=sipserver.automated.test" >> /etc/kamailio/kamctlrc \
 && echo "DBENGINE=MYSQL" >> /etc/kamailio/kamctlrc \
 && echo "DBRWUSER=root" >> /etc/kamailio/kamctlrc \
 && echo "DBRWPW=root" >> /etc/kamailio/kamctlrc \
 && echo "DBROUSER=root" >> /etc/kamailio/kamctlrc \
 && echo "DBROPW=root" >> /etc/kamailio/kamctlrc \
 && echo "INSTALL_EXTRA_TABLES=yes" >> /etc/kamailio/kamctlrc \
 && echo "INSTALL_PRESENCE_TABLES=yes" >> /etc/kamailio/kamctlrc \
 && echo "INSTALL_DBUID_TABLES=yes" >> /etc/kamailio/kamctlrc

RUN /etc/init.d/mysql start \
 && kamdbctl create

RUN sed -i '/#!KAMAILIO/a #!define WITH_MYSQL\n#!define WITH_AUTH\n#!define WITH_USRLOCDB' /etc/kamailio/kamailio.cfg \
 && sed -i 's/kamailio:kamailiorw/root:root/' /etc/kamailio/kamailio.cfg

RUN echo "RUN_KAMAILIO=yes" >> /etc/default/kamailio

EXPOSE 5060
