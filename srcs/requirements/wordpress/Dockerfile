FROM debian:bullseye

RUN apt-get update -y && apt-get install curl php-mysql php-fpm -y 

# Copy the www.conf file to the php-fpm7.4 directory to configure the php-fpm7.4.sock
COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/

# Create the directory for php-fpm7.4.sock
RUN mkdir /run/php 

COPY ./tools/wp.sh /tmp/wp.sh

RUN chmod +x /tmp/wp.sh

# Change directory to /var/www/html where the wordpress commands will be executed
WORKDIR /var/www/html/

CMD ["/tmp/wp.sh"]