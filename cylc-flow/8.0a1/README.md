# Cylc Flow

* Docker image: [kinow/cylc-flow](https://hub.docker.com/r/kinow/cylc-flow/)
* Base images: [python:3.7.6-alpine](https://hub.docker.com/_/python)
* Source: [Dockerfile](https://github.com/kinow/cylc-docker/blob/master/cylc-flow/8.0a1/Dockerfile), [Cylc](https://cylc.github.io/)
* Image size: 143.51 MB

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
$ docker run --name cylc-flow -t -i kinow/cylc-flow:8.0a1-alpine
bash-5.0$ whoami
cylc
bash-5.0$ cylc version
8.0a1
bash-5.0$ cylc register hello cylc-suites/hello/
REGISTERED hello -> /home/cylc/cylc-suites/hello
bash-5.0$ cylc run --no-detach hello
            ._.                                                       
            | |                 The Cylc Suite Engine [8.0a1]         
._____._. ._| |_____.           Copyright (C) 2008-2019 NIWA          
| .___| | | | | .___|   & British Crown (Met Office) & Contributors.  
| !___| !_! | | !___.  _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
!_____!___. |_!_____!  This program comes with ABSOLUTELY NO WARRANTY.
      .___! |              It is free software, you are welcome to    
      !_____!             redistribute it under certain conditions;   
                        see `COPYING' in the Cylc source distribution. 
                                                                       
2019-12-29T00:56:54Z INFO - Suite server: url=tcp://397e5643b9df:43053/ pid=86
2019-12-29T00:56:54Z INFO - Run: (re)start=0 log=1
2019-12-29T00:56:54Z INFO - Cylc version: 8.0a1
2019-12-29T00:56:54Z INFO - Run mode: live
2019-12-29T00:56:54Z INFO - Initial point: 1
2019-12-29T00:56:54Z INFO - Final point: 1
2019-12-29T00:56:54Z INFO - Cold Start 1
2019-12-29T00:56:54Z INFO - [Hello.1] -submit-num=01, owner@host=397e5643b9df
2019-12-29T00:56:54Z INFO - [Hello.1] -triggered off []
2019-12-29T00:56:56Z INFO - [client-command] put_messages cylc@397e5643b9df:cylc-message
2019-12-29T00:56:56Z INFO - [Hello.1] status=ready: (internal)submitted at 2019-12-29T00:56:55Z for job(01)
2019-12-29T00:56:56Z INFO - [Hello.1] -health check settings: submission timeout=None
2019-12-29T00:56:56Z INFO - [Hello.1] status=submitted: (received)started at 2019-12-29T00:56:56Z for job(01)
2019-12-29T00:56:56Z INFO - [Hello.1] -health check settings: execution timeout=None
2019-12-29T00:56:56Z INFO - [client-command] put_messages cylc@397e5643b9df:cylc-message
2019-12-29T00:56:57Z INFO - [Hello.1] status=running: (received)succeeded at 2019-12-29T00:56:56Z for job(01)
2019-12-29T00:56:57Z INFO - Suite shutting down - AUTOMATIC
2019-12-29T00:56:57Z INFO - DONE
bash-5.0$ 
```

## License

Licensed under the MIT License.

## References

- [Best practices for writing Dockerfiles](https://docs.docker.com/develop/develop-images/dockerfile_best-practices)
- [Reduce Docker Image Size for Machine Learning](https://jilongliao.com/2018/08/09/Reduce-Docker-Image-Size/)
- [alanbchristie/cylc-docker](https://github.com/alanbchristie/cylc-docker/)
