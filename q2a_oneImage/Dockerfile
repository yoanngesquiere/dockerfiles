FROM phusion/baseimage

RUN apt-get update
RUN apt-get -y install git
RUN apt-get install -y php5 apache2 libapache2-mod-php5 php5-mysql php5-cli mysql-client

#Mysql part
RUN apt-get -y install mysql-server

WORKDIR /var/www/html
RUN git clone https://github.com/q2a/question2answer.git
RUN mv question2answer/qa-config-example.php question2answer/qa-config.php

RUN sed -i -e 's/your-mysql-username/root/' question2answer/qa-config.php
RUN sed -i -e 's/your-mysql-password//' question2answer/qa-config.php
RUN sed -i -e 's/your-mysql-db-name/q2a/' question2answer/qa-config.php

RUN cat question2answer/qa-config.php

ENV APACHE_RUN_USER  www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_PID_FILE  /var/run/apache2.pid
ENV APACHE_RUN_DIR   /var/run/apache2
ENV APACHE_LOCK_DIR  /var/lock/apache2
ENV APACHE_LOG_DIR   /var/log/apache2
ENV APACHE_USER_UID 0

EXPOSE 80

ADD launch.sh /etc/my_init.d/launch.sh
RUN chmod +x /etc/my_init.d/launch.sh

CMD ["/sbin/my_init"]

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
