FROM stackbrew/debian:latest

MAINTAINER Florian FERRIERE ferriere.florian@gmail.com

ENV DEBIAN_FRONTED noninteractive
ENV TERM linux

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y procps net-tools supervisor apache2 libapache2-mod-php5 php5-json acl curl mysql-server mysql-client vim php5-mysqlnd php5-cli

RUN a2enmod rewrite

ADD vhost.conf /etc/apache2/sites-enabled/000-default
ADD start-apache.sh /usr/local/bin/start-apache.sh
ADD start-mysql.sh /usr/local/bin/start-mysql.sh
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD entrypoint.sh /usr/local/bin/entrypoint.sh

RUN adduser --disabled-password --gecos "" --uid 1000 --ingroup www-data user
RUN sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf

ADD xdebug.conf /xdebug.conf
RUN cat /xdebug.conf >> /etc/php5/apache2/conf.d/20-xdebug.ini

VOLUME ["/var/www/", "/var/log/supervisor", "/var/lib/mysql"]

EXPOSE 80

CMD ["/usr/local/bin/entrypoint.sh"]