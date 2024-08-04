#!/bin/sh

sleep 1

if [ ! -e /var/www/wordpress/ ]
then

	wp core download --allow-root --path='/var/www/wordpress'

fi

if [ ! -e /var/www/wordpress/wp-config.php ]
then
  # https://github.com/wp-cli/wp-cli/issues/5933 (Could not create 'wp-config.php' with wp-cli config create #5933)
  cd /var/www/wordpress || return

  wp config create --dbname="${MYSQL_DATABASE}" --dbuser="${MYSQL_USER}" --dbpass="${MYSQL_PASSWORD}" --dbhost=mariadb:3306 --allow-root
  sleep 5

  wp core install --url="${DOMAIN_NAME}" --title="${WP_TITLE}" --admin_user="${WP_ADMIN_USER}" --admin_password="${WP_ADMIN_PASSWORD}" --admin_email="${WP_ADMIN_EMAIL}" --allow-root
  sleep 5

  wp user create --role=author "${WP_USER_USER}" "${WP_USER_EMAIL}" --user_pass="${WP_USER_PASS}" --allow-root >> /log.txt
fi

service php7.4-fpm start

service php7.4-fpm stop

php-fpm7.4 -F 
