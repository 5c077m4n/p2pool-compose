FROM ubuntu:20.04 AS build
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install git build-essential cmake libuv1-dev libzmq3-dev libsodium-dev libpgm-dev libnorm-dev libgss-dev dumb-init
RUN git clone --recursive https://github.com/SChernykh/p2pool

RUN mkdir /src
WORKDIR /src

RUN mkdir build && cd build
RUN cmake ..
RUN make -j$(($(nproc) - 1))


FROM ubuntu:20.04

RUN mkdir /p2pool
WORKDIR /p2pool

COPY --from=builder /src/p2pool/build/p2pool /p2pool/p2pool
COPY --from=builder /src/p2pool/config.json /p2pool/config.json

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["dumb-init", "/entrypoint.sh"]
