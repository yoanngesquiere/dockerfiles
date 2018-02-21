FROM ubuntu:latest

RUN apt-get update
RUN apt-get install -y software-properties-common
RUN LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php -y
RUN apt-get update
RUN apt-get -y install git
RUN apt-get install -y php5.6 apache2 libapache2-mod-php5.6 php5.6-mysql php5.6-cli mysql-client

WORKDIR /var/www/html
RUN git clone https://github.com/q2a/question2answer.git
RUN mv question2answer/qa-config-example.php question2answer/qa-config.php

RUN sed -i -e 's/your-mysql-username/root/' question2answer/qa-config.php
RUN sed -i -e 's/your-mysql-password/root/' question2answer/qa-config.php
RUN sed -i -e 's/your-mysql-db-name/q2a/' question2answer/qa-config.php
RUN sed -i -e "s/'127.0.0.1'/getenv\('Q2A_DB_1_PORT_3306_TCP_ADDR'\)/" question2answer/qa-config.php

RUN cat question2answer/qa-config.php

ENV APACHE_RUN_USER  www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_PID_FILE  /var/run/apache2.pid
ENV APACHE_RUN_DIR   /var/run/apache2
ENV APACHE_LOCK_DIR  /var/lock/apache2
ENV APACHE_LOG_DIR   /var/log/apache2
ENV APACHE_USER_UID 0

EXPOSE 80

CMD ["/usr/sbin/apache2", "-D", "FOREGROUND"]

#When fig is up, RUN docker exec -ti q2a_web_1 /bin/bash
# then run mysql -h "$Q2A_DB_1_PORT_3306_TCP_ADDR"
# and CREATE DATABASE q2a;

