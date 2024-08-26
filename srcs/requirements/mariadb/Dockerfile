FROM debian:bullseye

RUN apt update && apt upgrade && apt install mariadb-server -y

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY ./tools/db.sh /tmp/db.sh

RUN chmod +x /tmp/db.sh

CMD ["/tmp/db.sh"]