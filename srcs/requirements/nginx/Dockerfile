FROM debian:bullseye

RUN apt-get update && apt-get install nginx libnss3-tools curl -y && apt-get clean

COPY ./tools/ng.sh /tmp/ng.sh

RUN chmod +x /tmp/ng.sh

CMD ["/tmp/ng.sh"]