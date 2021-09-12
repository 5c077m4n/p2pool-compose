FROM alpine:latest

RUN echo -e "http://dl-cdn.alpinelinux.org/alpine/edge/testing\nhttps://ftp.halifax.rwth-aachen.de/alpine/edge/testing" >> /etc/apk/repositories
RUN apk update && apk add --no-cache xmrig dumb-init

COPY config.json /usr/bin/
ENTRYPOINT ["dumb-init", "xmrig"]
