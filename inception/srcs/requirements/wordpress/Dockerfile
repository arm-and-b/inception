FROM debian:bullseye

RUN apt-get update -y
RUN apt-get upgrade -y

RUN apt-get -y install wget
RUN apt-get install -y php7.4 php-fpm php-mysql mariadb-client

RUN mkdir -p /run/php

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp
RUN chmod 755 /usr/local/bin/wp

COPY ./conf/php.conf /etc/php/7.4/fpm/pool.d/www.conf
COPY ./tools/wordpress.sh /tmp/wordpress.sh

RUN mkdir -p /var/www/html

WORKDIR /var/www/html

CMD ["bash", "/tmp/wordpress.sh"]
