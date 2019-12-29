# Standalone Cylc

* Docker image: [kinow/cylc-flow](https://hub.docker.com/r/kinow/cylc-flow/)
* Base images: [python:3.7.6-alpine](https://hub.docker.com/_/python)
* Source: [Dockerfile](https://github.com/kinow/cylc-docker/blob/master/cylc-flow/8.0a1/Dockerfile), [Cylc](https://cylc.github.io/)
* Image size: 113.49 MB

## Build the image

The name of the tag used to build the container is important if you intend
to run the container as a command.

```bash
$ docker build --tag kinow/cylc-flow:8.0a1-alpine .
```

This will create a container with alpine Linux, python 3.7.6, Cylc Flow dependencies, and
a version of Cylc Flow installed with `pip`.

### Running the container

You can run the container with the following command

```bash
$ docker run -t -i kinow/cylc-flow:8.0a1-alpine
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
