#!/bin/bash

if [ -f ./wp-config.php ]; then # Check if Wordpress is already installed
    echo "Wordpress exists already! No installation needed. Run php in foreground!"
else
    echo "Setting up Wordpress"
    
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar # Download WP-CLI

    chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp # Install WP-CLI and move it to /usr/local/bin for global use

    wp core download --allow-root # Download Wordpress

    wp config create --dbname=$DB_NAME --dbhost=$DB_HOST --dbuser=$DB_USERNAME --dbpass=$DB_PASSWORD --allow-root # Create wp-config.php

    wp core install --admin_user=$WP_ADMIN_USERNAME --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --url=$DOMAIN_NAME --title="Inception" --allow-root # Install Wordpress

    wp user create $WP_USER_USERNAME $WP_USER_EMAIL --role=author --user_pass=$WP_USER_PASSWORD --allow-root # Create a user with author role
fi

echo "Wordpress setup completed"

# Start PHP-FPM in the foreground
/usr/sbin/php-fpm7.4 -F