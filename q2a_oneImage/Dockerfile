FROM phusion/baseimage

RUN apt-get update
RUN apt-get -y install git
RUN apt-get install -y php5 apache2 libapache2-mod-php5 php5-mysql php5-cli mysql-client

#Mysql part
RUN apt-get -y install mysql-server

WORKDIR /var/www/html
RUN git clone https://github.com/q2a/question2answer.git
RUN cp -r question2answer/* ./
RUN mv qa-config-example.php qa-config.php

RUN rm /var/www/html/index.html

RUN sed -i -e 's/your-mysql-username/root/' qa-config.php
RUN sed -i -e 's/your-mysql-password//' qa-config.php
RUN sed -i -e 's/your-mysql-db-name/q2a/' qa-config.php

ENV APACHE_RUN_USER  www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_PID_FILE  /var/run/apache2.pid
ENV APACHE_RUN_DIR   /var/run/apache2
ENV APACHE_LOCK_DIR  /var/lock/apache2
ENV APACHE_LOG_DIR   /var/log/apache2
ENV APACHE_USER_UID 0


RUN /bin/bash -c "/usr/bin/mysqld_safe &" && \
  sleep 5 && \
  mysql -u root -e "CREATE DATABASE IF NOT EXISTS q2a;"

RUN mkdir /etc/service/mysql
RUN mkdir /etc/service/apache2
RUN echo "#!/bin/bash"  > /etc/service/mysql/run
RUN echo "mysqld_safe" >> /etc/service/mysql/run
RUN echo "#!/bin/bash"  > /etc/service/apache2/run
RUN echo "/usr/sbin/apache2 -D FOREGROUND" >> /etc/service/apache2/run
RUN chmod +x /etc/service/mysql/run
RUN chmod +x /etc/service/apache2/run

EXPOSE 80

CMD ["/sbin/my_init"]

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
