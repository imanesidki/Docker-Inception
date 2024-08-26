#!/bin/bash

# make directories for ssl certificates and keys
mkdir -p /etc/nginx/ssl

echo "Setting up Nginx and SSL"

curl -JL -o mkcert "https://dl.filippo.io/mkcert/latest?for=linux/amd64" # Download mkcert for linux

chmod +x mkcert && mv mkcert /usr/local/bin/
  
# Install mkcert and create a certificate for the domain name provided
mkcert -install &&
mkcert -key-file $CERT_KEY -cert-file $CERT_CRT $DOMAIN_NAME

echo "server {
            listen 443 ssl;

            server_name ${DOMAIN_NAME};
            ssl_certificate     ${CERT_CRT};
            ssl_certificate_key ${CERT_KEY};

            ssl_protocols       TLSv1.3;

            root /var/www/html;
            index index.php index.html index.htm;

            location / {
                try_files \$uri \$uri/ /index.php?\$args;
            }

            location ~ \.php$ {
                try_files \$uri =404;
                include fastcgi_params;
                fastcgi_pass wordpress:9000;
                fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
                fastcgi_index index.php;
            }
        }
        " > etc/nginx/conf.d/nginx.conf

echo "Nginx and SSL setup completed"

# Start nginx in the foreground
nginx -g "daemon off;"