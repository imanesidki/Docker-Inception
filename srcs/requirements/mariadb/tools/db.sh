#!/bin/bash

# Start MariaDB in the background
mysqld_safe &

# Wait for MariaDB to start
while ! mysqladmin ping --silent; do
    sleep 1
done

echo echo "Setting up MariaDB database"

# Secure MariaDB root and create database and user
mysql -uroot <<-EOSQL
    CREATE DATABASE IF NOT EXISTS $DB_NAME;
    CREATE USER IF NOT EXISTS '$DB_USERNAME'@'%' IDENTIFIED BY '$DB_PASSWORD';
    GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USERNAME'@'%';
    ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASSWORD';
    FLUSH PRIVILEGES;
EOSQL

# Stop the temporary MariaDB instance
mysqladmin -uroot -p$DB_ROOT_PASSWORD shutdown

echo echo "MariaDB database stup completed"

# Restart MariaDB in normal mode
mysqld_safe
