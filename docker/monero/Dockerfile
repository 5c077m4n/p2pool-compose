FROM alpine:latest

RUN echo -e "http://dl-cdn.alpinelinux.org/alpine/edge/testing\nhttps://ftp.halifax.rwth-aachen.de/alpine/edge/testing" >> /etc/apk/repositories

RUN apk update && apk --no-cache add monero dumb-init
VOLUME /root/.bitmonero

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["dumb-init", "/entrypoint.sh"]
