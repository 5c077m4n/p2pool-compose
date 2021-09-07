# Monero p2pool docker-compose

This is an easy to setup installation of Monero's [p2pool](https://github.com/SChernykh/p2pool), a decentralized pool for Monero mining.

## Requirements
* docker / podman
* docker-compose
* Huge pages setup and mounted under _/dev/hugepages_ or similar
  * `$ sudo sysctl vm.nr_hugepages=3072`
  * You can add `vm.nr_hugepages=3072` to _/etc/sysctl.conf_ so it persists reboots.
  * Check that you have _/dev/hugepages_ (or other) as a `hugetlbfs` mount
* At least 48 GiB of free space for pruned Monero and p2pool chain data.
  * _monero_ runs in pruned mode, but that's still about 38-39 GiB at the time of writing.
  * _p2pool_ uses 500 MiB at this point in time, could use more.
* x86_64 system (easy to fix, see Monero Dockerfile)
* About 4 GiB of RAM. Haven't tested below this, but should help during sync. A bit more works better. 

## How to
* Clone / download this repository
  * `$ git clone https://github.com/WeebDataHoarder/p2pool-compose && cd p2pool-compose`
* Copy _.env.example_ to _.env_
  * `$ cp .env.example .env`
* Change _.env_ values to fit your needs. This is the main configuration.
  * You don't need to change everything, but at least, you SHOULD change `P2POOL_WALLET_ADDRESS`.
  * You can override further by using `docker-compose.override.yml`.
* Build and start the services via _docker-compose_
  * `$ docker-compose up -d --build` (this will take a while to compile)
  * Monero syncing will also start. **This can take a few days.**
  * You can bring everything down via `$ docker-compose down`
  * View logs via `docker logs`
  * By default `master` branch of p2pool is used.
* To update (new version, or new p2pool version)
  * `git pull && docker-compose build --no-cache p2pool && docker-compose up -d --build`

## Notes
* _monerod_ has higher connection defaults and several presets to have quicker and larger reach when receiving and broadcasting new blocks.
* _monerod_ has a custom patch applied for the special RPC and ZMQ methods p2pool requires. After [PR#7891](https://github.com/monero-project/monero/pull/7891) is merged, this patch won't be necessary. 
* _p2pool_ stratum port is by default 3333. You can change this on _.env_, and can also point xmrig-proxy or similar to this port.
* _p2pool_ will wait until _monerod_ is running and fully synchronized before starting.
* Everything restarts by default

## TODO
* logrotate for p2pool
  * However, you can set this up yourself directly pointing to file `/var/lib/docker/volumes/monero-pool_p2pool/_data/p2pool.log`

## Contribution
* There is no dev fee. p2pool has no infrastructure. Send donations if you like, or don't.
* Feel free to send (or mine!) a tip to the following address
```4AeEwC2Uik2Zv4uooAUWjQb2ZvcLDBmLXN4rzSn3wjBoY8EKfNkSUqeg5PxcnWTwB1b2V39PDwU9gaNE5SnxSQPYQyoQtr7```
* Also donate to [p2pool's original author](https://github.com/SChernykh/p2pool#donations). 