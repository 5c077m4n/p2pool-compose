#!/bin/sh

ulimit -v 5000000
monerod \
	--zmq-pub=tcp://0.0.0.0:18083 --rpc-bind-ip=0.0.0.0 --rpc-bind-port 18081 \
	--non-interactive --confirm-external-bind --restricted-rpc --allow-local-ip --no-igd \
	--fast-block-sync 1 --max-concurrency $(($(nproc) - 1)) --block-sync-size 100 --sync-pruned-blocks --prune-blockchain \
	--enforce-dns-checkpointing \
	--in-peers 64 \
	--out-peers 128 \
	--add-priority-node node.supportxmr.com:18080 \
	--add-priority-node opennode.xmr-tw.org:18080 \
	--add-priority-node node.moneroworld.com:18080 \
	--add-priority-node uwillrunanodesoon.moneroworld.com:18080 \
	--add-priority-node nodes.hashvault.pro:18080 \
	--add-priority-node monero.sphinxlogic.com:18080 \
	--add-priority-node monero.nolog.network:18080 \
	--add-priority-node node.monerooutreach.org:18080 \
	--add-priority-node nodex.monerujo.io:18080 \
	"$@"
