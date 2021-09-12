FROM ubuntu:20.04 AS builder

ENV DEBIAN_FRONTEND=noninteractive
ARG ref=origin/master

RUN apt-get update && \
	apt-get install -y \
		git \
		build-essential \
		cmake \
		libuv1-dev \
		libzmq3-dev \
		libsodium-dev \
		libpgm-dev \
		libnorm-dev \
		libgss-dev

RUN git clone --recursive https://github.com/SChernykh/p2pool /src/p2pool && \
	cd /src/p2pool && git reset --hard ${ref} && git submodule sync && \
	mkdir build && cd build && \
	CFLAGS="-march=native -mtune=native -Ofast -Wno-error=unused-variable" CXXFLAGS="-march=native -mtune=native -Ofast -Wno-error=unused-variable" \
	cmake .. && \
	make -j$(($(nproc) - 1))

FROM ubuntu:20.04
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
	apt-get install -y \
		libuv1 \
		libzmq5 \
		libsodium23 \
		libpgm-5.3-0 \
		libnorm1 \
		libgss3 \
		curl \
		jq \
		dumb-init

RUN mkdir /p2pool

COPY --from=builder /src/p2pool/build/p2pool /p2pool/p2pool
COPY --from=builder /src/p2pool/config.json /p2pool/config.json

EXPOSE 3333 37889

WORKDIR /p2pool/data

RUN adduser --group --disabled-password monero
USER monero

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["dumb-init", "/entrypoint.sh"]
