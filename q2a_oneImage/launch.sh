#!/bin/bash
mysqld_safe &
sleep 10
echo "CREATE DATABASE IF NOT EXISTS q2a ;" | mysql -h localhost
/usr/sbin/apache2