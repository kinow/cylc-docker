# Standalone Cylc

In this distributed example, Cylc will be scheduled from one container, but executed
on multiple.

## Prerequisites

You will need an SSH key to connect to the running containers via SSH.

```bash
$ ssh-keygen -t rsa -f ./id_rsa -N "" -q
```

## Build the image

```bash
$ CYLC_SSH_PUBKEY=$(cat id_rsa.pub)
$ docker-compose up -d --scale cylc-ssh=2
```

## Connecting to the container via SSH

```bash
$ docker build --tag cylc-ssh .
$ cat id_rsa.pub | xargs -I{} docker run -d -p 4222:22 -v "$(pwd)"/cylc:/opt/cylc cylc-ssh {}
c480bce9a6df0af1534f9c4223b6208d904f79747d9e0e3fd92745926c7f0661
$ ssh root@localhost -p4222 -o IdentitiesOnly=yes -i "$(pwd)"/id_rsa
```

## License

Licensed under the MIT License.

## References

- [Best practices for writing Dockerfiles](https://docs.docker.com/develop/develop-images/dockerfile_best-practices)
- [docker-compose scale](https://docs.docker.com/compose/reference/scale/)
- [jenkinsci/docker-ssh-slave](https://github.com/jenkinsci/docker-ssh-slave/blob/master/Dockerfile)
