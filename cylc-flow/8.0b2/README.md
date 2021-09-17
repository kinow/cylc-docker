# Cylc Flow

* Docker image: [kinow/cylc-flow](https://hub.docker.com/r/kinow/cylc-flow/)
* Base images: [python:3.7.12-alpine](https://hub.docker.com/_/python)
* Source: [Dockerfile](https://github.com/kinow/cylc-docker/blob/master/cylc-flow/8.0a3/Dockerfile), [Cylc](https://cylc.github.io/)
* Image size: 73.4 MB

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
bash-5.1$ whoami
cylc
bash-5.1$ cylc version
8.0b2
bash-5.1$ cylc install --directory=cylc-suites/hello --flow-name=myhello
INSTALLED myhello/run1 from cylc-suites/hello
bash-5.1$ cylc play --no-detach myhello/run1
cylc play --no-detach myhello/run1

                Cylc Workflow Engine 8.0b2
                Copyright (C) 2008-2021 NIWA
                & British Crown (Met Office) & Contributors

2021-09-17T00:38:01Z WARNING - The filename "suite.rc" is deprecated in favour of "flow.cylc"
2021-09-17T00:38:01Z INFO - Cold start from 1
2021-09-17T00:38:01Z INFO - Scheduler: url=tcp://a392daf1bd3f:43089/ pid=48
2021-09-17T00:38:01Z INFO - Workflow publisher: url=tcp://a392daf1bd3f:43019
2021-09-17T00:38:01Z INFO - Run: (re)start=0 log=1
2021-09-17T00:38:01Z INFO - Cylc version: 8.0b2
2021-09-17T00:38:01Z INFO - Run mode: live
2021-09-17T00:38:01Z INFO - Initial point: 1
2021-09-17T00:38:01Z INFO - Final point: None
2021-09-17T00:38:01Z INFO - [hello.1] -released from runahead
2021-09-17T00:38:01Z INFO - Queue released: hello.1
2021-09-17T00:38:01Z INFO - [hello.1] -submit-num=01, host=a392daf1bd3f
2021-09-17T00:38:01Z INFO - [hello.1] -triggered off []
2021-09-17T00:38:02Z INFO - [hello.1] status=preparing: (internal)submitted at 2021-09-17T00:38:02Z  for job(01) flow(g)
2021-09-17T00:38:02Z INFO - [hello.1] -health check settings: submission timeout=None, polling intervals=PT15M,...
2021-09-17T00:38:03Z INFO - [hello.1] status=submitted: (received)started at 2021-09-17T00:38:02Z  for job(01) flow(g)
2021-09-17T00:38:03Z INFO - [hello.1] -health check settings: execution timeout=None, polling intervals=PT15M,...
2021-09-17T00:38:13Z INFO - [hello.1] status=running: (received)succeeded at 2021-09-17T00:38:12Z  for job(01) flow(g)
2021-09-17T00:38:13Z INFO - Workflow shutting down - AUTOMATIC
2021-09-17T00:38:13Z INFO - DONE
bash-5.1$ 
```

## License

Licensed under the MIT License.

## References

- [Best practices for writing Dockerfiles](https://docs.docker.com/develop/develop-images/dockerfile_best-practices)
- [Reduce Docker Image Size for Machine Learning](https://jilongliao.com/2018/08/09/Reduce-Docker-Image-Size/)
- [alanbchristie/cylc-docker](https://github.com/alanbchristie/cylc-docker/)
