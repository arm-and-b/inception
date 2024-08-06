FROM debian:bullseye

RUN apt update -y
RUN apt upgrade -y
RUN apt-get install mariadb-server -y
COPY conf/50-server.cnf	/etc/mysql/mariadb.conf.d/50-server.cnf
RUN mkdir -p var/run/mysqld && chown -R mysql:mysql var/run/mysqld && chmod 755 var/run/mysqld
COPY tools/mysql.sh /tmp/mysql.sh
RUN chmod +x /tmp/mysql.sh
CMD ["/tmp/mysql.sh"]
