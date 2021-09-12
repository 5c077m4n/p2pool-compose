#!/bin/sh

set -ex

/p2pool/p2pool \
	--config "/p2pool/config.json" \
	--host monero \
	--rpc-port 18081 \
	--zmq-port 18083 \
	"$@"
