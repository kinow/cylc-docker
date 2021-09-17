# Cylc Flow

* Docker image: [kinow/cylc-flow](https://hub.docker.com/r/kinow/cylc-flow/)
* Base images: [python:3.7.12-alpine](https://hub.docker.com/_/python)
* Source: [Dockerfile](https://github.com/kinow/cylc-docker/blob/master/cylc-flow/8.0a3/Dockerfile), [Cylc](https://cylc.github.io/)
* Image size: 143.51 MB

## Build the image

The name of the tag used to build the container is important if you intend
to run the container as a command.

```bash
$ docker build --tag kinow/cylc-flow:8.0b2-alpine .
```

This will create a container with alpine Linux, python 3.7.12, Cylc Flow dependencies, and
a version of Cylc Flow installed with `pip`.

### Running the container

You can run the container with the following command

```bash
$ docker run --rm --name cylc-flow -t -i kinow/cylc-flow:8.0b2-alpine
bash-5.0$ whoami
cylc
bash-5.0$ cylc version
8.0b2
bash-5.0$ cylc install --directory=cylc-suites/hello --flow-name=myhello
INSTALLED myhello/run1 from cylc-suites/hello
bash-5.0$ cylc play --no-detach myhello/run1
TODO
bash-5.0$ 
```

## License

Licensed under the MIT License.

## References

- [Best practices for writing Dockerfiles](https://docs.docker.com/develop/develop-images/dockerfile_best-practices)
- [Reduce Docker Image Size for Machine Learning](https://jilongliao.com/2018/08/09/Reduce-Docker-Image-Size/)
- [alanbchristie/cylc-docker](https://github.com/alanbchristie/cylc-docker/)
