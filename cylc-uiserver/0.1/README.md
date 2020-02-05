# Cylc Flow

* Docker image: [kinow/cylc-uiserver](https://hub.docker.com/r/kinow/cylc-uiserver/)
* Base images: [python:3.7.6-alpine](https://hub.docker.com/_/python)
* Source: [Dockerfile](https://github.com/kinow/cylc-docker/blob/master/cylc-uiserver/0.1/Dockerfile), [Cylc](https://cylc.github.io/)
* Image size: 206 MB

## Build the image

The name of the tag used to build the container is important if you intend
to run the container as a command.

```bash
$ docker build -t kinow/cylc-uiserver:0.1-alpine .
```

This will create a container with alpine Linux, python 3.7.6, Cylc UI Server, and
a version of Cylc Flow installed with `pip`.

NB: This is a test container, not intendend to be used in production. At the moment
it does not support PAM on Alpine Linux, so it is using the JupyterHub Dummy
Authenticator, which is recommended only for development.

### Running the container

You can run the container with the following command

```bash
$ docker run --name cylc-uiserver --rm -d -p 8000:8000 kinow/cylc-uiserver:0.1-alpine
966c21ca7a2237fd9ad0d703a89a722dc8760f379355c09aff1f857842bc1046
```

Then access Cylc UI Server on `http://localhost:8000` and log in using the user `cylc`
and any password. To visualize the logs, you can quickly use `docker logs cylc-uiserver`.

## License

Licensed under the MIT License.

## References

- [Best practices for writing Dockerfiles](https://docs.docker.com/develop/develop-images/dockerfile_best-practices)
- [Reduce Docker Image Size for Machine Learning](https://jilongliao.com/2018/08/09/Reduce-Docker-Image-Size/)
