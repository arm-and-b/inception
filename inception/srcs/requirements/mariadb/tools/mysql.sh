#!/bin/sh

service mariadb start

sleep 5


#mysql -uroot -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'wordpress.srcs_inception' IDENTIFIED BY '${MYSQL_PASSWORD}';"
#mysql -uroot -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'wordpress.srcs_inception' WITH GRANT OPTION;"
#mysql -uroot -e "ALTER USER '${MYSQL_USER}'@'wordpress.srcs_inception' IDENTIFIED BY '${MYSQL_PASSWORD}';"

mysql -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"
mysql -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON *.* TO '${MYSQL_ROOT_USER}'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
mysql -e "ALTER USER '${MYSQL_ROOT_USER}'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
mysql -e "FLUSH PRIVILEGES;"

#mysql -uroot -p"${MYSQL_ROOT_PASSWORD}" -e "FLUSH PRIVILEGES;"
#mysql -uroot -p"${MYSQL_ROOT_PASSWORD}" -e "SHUTDOWN;"

sleep 1

mysqladmin -u${MYSQL_ROOT_USER} -p${MYSQL_ROOT_PASSWORD} shutdown

exec mysqld_safe
