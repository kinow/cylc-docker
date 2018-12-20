# Cylc and PBS with Docker

## Prerequisites

You will need an SSH key to connect to the running containers via SSH.

```bash
$ ssh-keygen -t rsa -f ./id_rsa -N "" -q
```

Then export to the `docker-compose` `.env` file.

```bash
$ export CYLC_SSH_PUBKEY=cat $(id_rsa.pub)
$ echo "CYLC_SSH_PUBKEY=${CYLC_SSH_PUBKEY}" >> .env
```

## PBS

First you need to have a container running PBS. One existing image that works well is
[`agaveapi/torque`](https://hub.docker.com/r/agaveapi/torque), which provides PBS Torque.

It also offers SSH access out of the box, so we can use this image as part of the
cluster.

Remote job hosts must include Cylc, so in this directory you should find a `Dockerfile`
that uses `agaveapi/torque`, but adds some Python packages to make it ready for Cylc.

First we need a network for our cluster.

```bash
$ docker network create cylcpbs
$ docker network ls
NETWORK ID          NAME                  DRIVER              SCOPE
4ee8711efc86        bridge                bridge              local
b2305ea25f54        cylcpbs               bridge              local
```

Then we can build the image and start a container with Torque.

```bash
$ docker build . -t cylcpbs1:latest
$ docker run -d -v $(pwd)/cylc:/opt/cylc -v ${HOME}/cylc-run:/root/cylc-run -v ${HOME}/.cylc:/root/.cylc -h cylcpbs1 --network cylcpbs -p 10022:22 --name cylcpbs1 --privileged cylcpbs1:latest
$ ssh -p 10022 testuser@cylcpbs1
testuser@localhost's password: 
[testuser@cylcpbs1 ~]$ logout
Connection to localhost closed.
$ docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                                        NAMES
4a24c7d58637        cylcpbs1:latest     "/docker_entrypoint.…"   38 seconds ago      Up 37 seconds       9618/tcp, 10389/tcp, 0.0.0.0:10022->22/tcp   cylcpbs1
```

```bash
$ docker run -t -i --network cylcpbs --entrypoint /bin/bash kinow/cylc-standalone:0.1
```
