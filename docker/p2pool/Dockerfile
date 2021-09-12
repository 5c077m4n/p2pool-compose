FROM ubuntu:20.04 AS build
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install --yes git build-essential cmake libuv1-dev libzmq3-dev libsodium-dev libpgm-dev libnorm-dev libgss-dev
RUN git clone --recursive https://github.com/SChernykh/p2pool /src
WORKDIR /src

RUN mkdir build
WORKDIR build

RUN cmake ..
RUN make -j$(($(nproc) - 1))

FROM ubuntu:20.04

RUN apt-get update && apt-get install --yes dumb-init curl jq

RUN mkdir /p2pool
WORKDIR /p2pool

COPY --from=build /src/build/ ./
COPY --from=build /src/config.json ./

EXPOSE 3333 37889

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["dumb-init", "/entrypoint.sh"]
