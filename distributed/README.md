# Distributed Cylc

* Docker image: [kinow/cylc-distributed](https://hub.docker.com/r/kinow/cylc-distributed/)
* Base images: [cylc-standalone](https://hub.docker.com/r/kinow/cylc-standalone/), [ubuntu:16.04](https://hub.docker.com/_/ubuntu/)
* Source: [Dockerfile](https://github.com/kinow/cylc-docker/blob/master/distributed/Dockerfile), [Cylc](https://cylc.github.io/cylc/)

In this distributed example, Cylc will be scheduled from one container, but executed
on multiple.

## Prerequisites

You will need an SSH key to connect to the running containers via SSH.

```bash
$ ssh-keygen -t rsa -f ./id_rsa -N "" -q
```

## Starting up the containers

Given you have the SSH public and private keys in the current directory, you must be able to
run the following command to start 5 boxes with Cylc and SSH configured, and one jump box with
Cylc and SSH with the certificates configured.

```bash
$ CYLC_SSH_PUBKEY=$(cat id_rsa.pub) docker-compose up -d --scale cylc-ssh=5 --scale cylc-jump-box=1
```

Confirm that the services are running.

```bash
$docker ps
CONTAINER ID        IMAGE                       COMMAND             CREATED              STATUS              PORTS                   NAMES
880f0ff29dd3        distributed_cylc-ssh        "setup-sshd"        About a minute ago   Up About a minute   0.0.0.0:32779->22/tcp   distributed_cylc-ssh_1
2a06236fec5f        distributed_cylc-ssh        "setup-sshd"        About a minute ago   Up About a minute   0.0.0.0:32778->22/tcp   distributed_cylc-ssh_5
c97e502c2e15        distributed_cylc-jump-box   "setup-sshd"        About a minute ago   Up About a minute   22/tcp                  distributed_cylc-jump-box_1
8bc57ba12af2        distributed_cylc-ssh        "setup-sshd"        About a minute ago   Up About a minute   0.0.0.0:32776->22/tcp   distributed_cylc-ssh_4
8671c279918f        distributed_cylc-ssh        "setup-sshd"        About a minute ago   Up About a minute   0.0.0.0:32777->22/tcp   distributed_cylc-ssh_3
b62e7b2ac4a5        distributed_cylc-ssh        "setup-sshd"        About a minute ago   Up About a minute   0.0.0.0:32775->22/tcp   distributed_cylc-ssh_2
```

You can use Cylc from the container, without having to access the container directly.

```bash
$ docker exec -ti distributed_cylc-jump-box_1 cylc check-software
```

## Using the jump box from a terminal

You can start a terminal in the jump box container. From this container you should be able to access
the other 5 containers.

```bash
$ docker exec -ti distributed_cylc-jump-box_1 /bin/bash
root@c97e502c2e15:/opt/cylc# cylc check-software
Checking your software...

Individual results:
==========================================================================================
Package (version requirements)                                     Outcome (version found)
==========================================================================================
                                   *REQUIRED SOFTWARE*                                   
Python (2.6+, <3)................................FOUND & min. version MET (2.7.12.final.0)

             *OPTIONAL SOFTWARE for the GUI & dependency graph visualisation*             
/usr/lib/python2.7/dist-packages/gtk-2.0/gtk/__init__.py:57: GtkWarning: could not open display
  warnings.warn(str(e), _gtk.Warning)
Python:pygtk (2.0+)......................................FOUND & min. version MET (2.24.0)
graphviz (any)..............................................................FOUND (2.38.0)
Python:pygraphviz (any)......................................................FOUND (1.3.1)

                       *OPTIONAL SOFTWARE for the HTML User Guide*                       
ImageMagick (any)............................................................NOT FOUND (-)

                  *OPTIONAL SOFTWARE for the HTTPS communications layer*                  
Python:urllib3 (any).........................................................NOT FOUND (-)
Python:OpenSSL (any)........................................................FOUND (18.0.0)
Python:requests (2.4.2+).....................................................NOT FOUND (-)

                       *OPTIONAL SOFTWARE for the LaTeX User Guide*                       
TeX:framed (any).............................................................NOT FOUND (-)
TeX (3.0+)...........................................FOUND & min. version MET (3.14159265)
TeX:preprint (any)...........................................................NOT FOUND (-)
TeX:tex4ht (any).............................................................NOT FOUND (-)
TeX:tocloft (any)............................................................NOT FOUND (-)
TeX:texlive (any)............................................................NOT FOUND (-)
==========================================================================================

Summary:
                               ****************************                               
                                  Core requirements: ok                                  
                                Full-functionality: not ok                                
                               **************************** 
```

And you are able to run the suites from the Cylc installation.

```bash
$ docker exec -ti distributed_cylc-jump-box_1 cylc start --non-daemon --debug /opt/cylc/etc/examples/tutorial/oneoff/basic/
```

You can also include this extra remote suite that will test the Docker containers.

```bash
$ cp -r remote-suite/ cylc/etc/dev-suites/
$ docker exec -ti distributed_cylc-jump-box_1 cylc start --non-daemon --debug /opt/cylc/etc/dev-suites/remote-suite
            ._.                                                       
            | |                 The Cylc Suite Engine [7.7.2]         
._____._. ._| |_____.           Copyright (C) 2008-2018 NIWA          
| .___| | | | | .___|  _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
| !___| !_! | | !___.  This program comes with ABSOLUTELY NO WARRANTY;
!_____!___. |_!_____!  see `cylc warranty`.  It is free software, you 
      .___! |           are welcome to redistribute it under certain  
      !_____!                conditions; see `cylc conditions`.       
2018-08-02T09:41:33Z INFO - Suite starting: server=ca871dd12e1e:43070 pid=1285
2018-08-02T09:41:33Z INFO - Cylc version: 7.7.2
2018-08-02T09:41:33Z INFO - Run mode: live
2018-08-02T09:41:33Z INFO - Initial point: 20120101
2018-08-02T09:41:33Z INFO - Final point: 20120110
2018-08-02T09:41:33Z INFO - Cold Start 20120101
2018-08-02T09:41:33Z DEBUG - [remote_10_1.20120101] -released to the task pool
2018-08-02T09:41:33Z DEBUG - [remote_10_2.20120101] -released to the task pool
2018-08-02T09:41:33Z DEBUG - [local_9.20120101] -released to the task pool
...
...
...
2018-08-02T09:41:57Z DEBUG - [remote_6_1.20120101] -running => succeeded
2018-08-02T09:41:57Z INFO - [remote_5_1.20120101] -(current:running)> succeeded at 2018-08-02T09:41:56Z
2018-08-02T09:41:57Z DEBUG - [remote_5_1.20120101] -running => succeeded
2018-08-02T09:41:57Z INFO - [remote_5_2.20120101] -(current:running)> succeeded at 2018-08-02T09:41:56Z
2018-08-02T09:41:57Z DEBUG - [remote_5_2.20120101] -running => succeeded
2018-08-02T09:41:57Z INFO - [remote_4_1.20120101] -(current:running)> succeeded at 2018-08-02T09:41:56Z
2018-08-02T09:41:57Z DEBUG - [remote_4_1.20120101] -running => succeeded
2018-08-02T09:41:57Z INFO - [remote_4_2.20120101] -(current:running)> succeeded at 2018-08-02T09:41:56Z
2018-08-02T09:41:57Z DEBUG - [remote_4_2.20120101] -running => succeeded
2018-08-02T09:41:57Z INFO - Suite shutting down - AUTOMATIC
2018-08-02T09:41:58Z INFO - DONE
```

Once you are done, you can stop the containers.

```bash
$ docker-compose down
```

## Simulating Slower Network Connections

The containers started with `docker-compose.yml` contain the NET_ADMIN capability enabled, plus
the `tc` utility installed.

We can limit the network latency through the following command:

```bash
$ docker ps | grep -E "distributed_cylc-.*" -o | awk '{print $NF}' | xargs -I{} docker exec {} tc qdisc add dev eth0 root netem delay 200ms
```

And disable it with:

```bash
$ docker ps | grep -E "distributed_cylc-.*" -o | awk '{print $NF}' | xargs -I{} docker exec {} tc qdisc del dev eth0 root netem
```

Both commands exit with status code 0, and normally no output.

You can then start an experiment with the remote suite, with the following commands.

```bash
$ cp remote-suite/remote.json cylc/etc/profile-experiments/remote.json
$ docker exec -ti distributed_cylc-jump-box_1 cylc profile-battery -e remote -p --full
```

The first command puts the `remote.json` experiment in a folder within the Cylc installation,
which is mapped as a volume in the containers. Then, the second command initialises the experiment.

Without the latency, you should see results such as:

```
Version                HEAD        
Run                    remote suite
Elapsed Time (s)       24.6        
CPU Time - Total (s)   2.7         
CPU Time - User (s)    2.2         
CPU Time - System (s)  0.5         
Max Memory (kb)        41760.0     
File System - Inputs   0.0         
File System - Outputs  5896.0 
```

Whereas once enabled a latency of around 200ms, you should notice an increase in the
total execution time.

```
Version                HEAD        
Run                    remote suite
Elapsed Time (s)       49.6        
CPU Time - Total (s)   9.2         
CPU Time - User (s)    7.2         
CPU Time - System (s)  1.9         
Max Memory (kb)        41744.0     
File System - Inputs   0.0         
File System - Outputs  7080.0
```

Another option is to reduce the bandwidth.

```bash
$ docker ps | grep -E "distributed_cylc-.*" -o | awk '{print $NF}' | xargs -I{} docker exec {} tc qdisc add dev eth0 handle 1: root htb default 11
$ docker ps | grep -E "distributed_cylc-.*" -o | awk '{print $NF}' | xargs -I{} docker exec {} tc class add dev eth0 parent 1: classid 1:1 htb rate 512kbps
$ docker ps | grep -E "distributed_cylc-.*" -o | awk '{print $NF}' | xargs -I{} docker exec {} tc class add dev eth0 parent 1:1 classid 1:11 htb rate 512kbps
```

And to undo the changes:

```bash
$ docker ps | grep -E "distributed_cylc-.*" -o | awk '{print $NF}' | xargs -I{} docker exec {} tc qdisc del dev eth0 root
```

## Connecting to the container via SSH

If you would like to explore the running containers, you can start it manually and connect via SSH with
the following commands.

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
