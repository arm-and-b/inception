#!/bin/sh

sleep 1

if [ -f /var/www/wordpress/wp-config.php ];
then
	echo "WP INSTALLED";
else
	wp core download --allow-root
	
  	wp config create --dbname="${MYSQL_DATABASE}" --dbuser="${MYSQL_USER}" --dbpass="${MYSQL_PASSWORD}" --dbhost=mariadb:3306 --allow-root
  	sleep 5

  	wp core install --url="${DOMAIN_NAME}" --title="${WP_TITLE}" --admin_user="${WP_ADMIN_USER}" --admin_password="${WP_ADMIN_PASSWORD}" --admin_email="${WP_ADMIN_EMAIL}" --allow-root
  	sleep 5

  	wp user create --role=author "${WP_USER_USER}" "${WP_USER_EMAIL}" --user_pass="${WP_USER_PASS}" --allow-root >> /log.txt
fi

wp plugin list --allow-root

chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html

exec /usr/sbin/php-fpm7.4 -F
