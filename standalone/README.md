# Standalone Cylc

* Docker image: [kinow/cylc-standalone](https://hub.docker.com/r/kinow/cylc-standalone/)
* Base images: [ubuntu:16.04](https://hub.docker.com/_/ubuntu/)
* Source: [Dockerfile](https://github.com/kinow/cylc-docker/blob/master/standalone/Dockerfile), [Cylc](https://cylc.github.io/cylc/)

In this standalone example, one Cylc container will both schedule and execute all tasks.

## Build the image

The name of the tag used to build the container is important if you intend
to run the container as a command.

```bash
$ docker build --tag kinow/cylc:8.0a1-alpine .
```

This will create a container with alpine Linux, python 3.7, Cylc dependencies, and
a version of Cylc installed with `pip`.

### Running the container

You can run the container with the following command

```bash
$ docker run -t -i kinow/cylc:8.0a1-alpine
bash-4.4# whoami
cylc
bash-4.4# cylc version
8.0a1
bash-4.4# cylc run --no-detach --verbose --debug hello
...
```

## License

Licensed under the MIT License.

## References

- [Best practices for writing Dockerfiles](https://docs.docker.com/develop/develop-images/dockerfile_best-practices)
- [Reduce Docker Image Size for Machine Learning](https://jilongliao.com/2018/08/09/Reduce-Docker-Image-Size/)
