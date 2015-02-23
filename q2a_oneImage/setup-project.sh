#!/bin/bash
set -e

if [ ! -d /var/lib/mysql/mysql ]; then
    mysql_install_db
fi

# Démarrer la BDD
/usr/bin/mysqld_safe &

until [ -x /var/run/mysqld/mysqld.sock ]
do
    sleep 1
done

echo 'CREATE DATABASE IF NOT EXISTS q2a;' | mysql -uroot

mysqladmin shutdown
