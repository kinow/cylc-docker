# Cylc and PBS with Docker

## Prerequisites

You will need an SSH key to connect to the running containers via SSH.

```bash
$ ssh-keygen -t rsa -f ./id_rsa -N "" -q
```

Then export to the `docker-compose` `.env` file.

```bash
$ export CYLC_SSH_PUBKEY=$(cat id_rsa.pub)
$ echo "CYLC_SSH_PUBKEY=${CYLC_SSH_PUBKEY}" >> .env
```

## Running Cylc locally

To start the mini cluster for testing, just try the following.

```bash
$ docker-compose up --build
Building cylc
Step 1/14 : FROM kinow/cylc-standalone:0.1
 ---> b9babc40ce51
Step 2/14 : RUN apt-get update && apt-get --no-install-recommends -y install 	inetutils-ping 	less 	python-empy 	python-requests 	ssh 	supervisor
 ---> Using cache
 ---> 0a690770cb4a
...
...
Building pbs
Step 1/14 : FROM agaveapi/torque:latest
 ---> 8d68923d702c
Step 2/14 : ARG CYLC_SSH_PUBKEY
 ---> Using cache
 ---> 8876918dc0a1
...
...
Attaching to cylc, pbs
cylc_1  | /usr/lib/python2.7/dist-packages/supervisor/options.py:297: UserWarning: Supervisord is running as root and it is searching for its configuration file in default locations (including its current working directory); you probably want to specify a "-c" argument specifying an absolute path to a configuration file for improved security.
cylc_1  |   'Supervisord is running as root and it is searching '
cylc_1  | 2018-12-20 21:52:48,744 CRIT Supervisor running as root (no user in config file)
cylc_1  | 2018-12-20 21:52:48,744 WARN No file matches via include "/etc/supervisor/conf.d/*.conf"
cylc_1  | 2018-12-20 21:52:48,760 INFO RPC interface 'supervisor' initialized
cylc_1  | 2018-12-20 21:52:48,760 CRIT Server 'unix_http_server' running without any HTTP authentication checking
cylc_1  | 2018-12-20 21:52:48,760 INFO supervisord started with pid 1
pbs_1   | /usr/lib/python2.6/site-packages/supervisor/options.py:295: UserWarning: Supervisord is running as root and it is searching for its configuration file in default locations (including its current working directory); you probably want to specify a "-c" argument specifying an absolute path to a configuration file for improved security.
pbs_1   |   'Supervisord is running as root and it is searching '
pbs_1   | 2018-12-20 21:52:49,618 CRIT Supervisor running as root (no user in config file)
pbs_1   | 2018-12-20 21:52:49,624 INFO supervisord started with pid 1
pbs_1   | 2018-12-20 21:52:50,627 INFO spawned: 'pbsmom' with pid 10
pbs_1   | 2018-12-20 21:52:50,629 INFO spawned: 'sshd' with pid 11
pbs_1   | 2018-12-20 21:52:50,630 INFO spawned: 'pbssched' with pid 12
pbs_1   | 2018-12-20 21:52:50,632 INFO spawned: 'pbsserver' with pid 13
pbs_1   | 2018-12-20 21:52:50,633 INFO spawned: 'trqauthd' with pid 14
pbs_1   | 2018-12-20 21:52:51,032 INFO exited: pbssched (exit status 0; not expected)
pbs_1   | 2018-12-20 21:52:51,499 INFO gave up: pbssched entered FATAL state, too many start retries too quickly
pbs_1   | 2018-12-20 21:52:51,841 INFO success: pbsmom entered RUNNING state, process has stayed up for > than 1 seconds (startsecs)
pbs_1   | 2018-12-20 21:52:51,841 INFO success: sshd entered RUNNING state, process has stayed up for > than 1 seconds (startsecs)
pbs_1   | 2018-12-20 21:52:51,841 INFO success: pbsserver entered RUNNING state, process has stayed up for > than 1 seconds (startsecs)
pbs_1   | 2018-12-20 21:52:51,841 INFO success: trqauthd entered RUNNING state, process has stayed up for > than 1 seconds (startsecs)
```

Now you have two boxes with Cylc, and with the `testuser` user properly configured,
with SSH keys in the cylc box, and an entry in its `authorized_keys` file in the PBS
server.

It means that you can start a suite in the `cylc` box.

```bash
$ cylc register five /opt/cylc/etc/examples/tutorial/cycling/five/
REGISTERED five -> /opt/cylc/etc/examples/tutorial/cycling/five
$ cylc run --no-detach five
            ._.                                                       
            | |        The Cylc Suite Engine [7.7.1-398-g7e472-dirty] 
._____._. ._| |_____.           Copyright (C) 2008-2018 NIWA          
| .___| | | | | .___|   & British Crown (Met Office) & Contributors.  
| !___| !_! | | !___.  _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
!_____!___. |_!_____!  This program comes with ABSOLUTELY NO WARRANTY;
      .___! |          see `cylc warranty`.  It is free software, you 
      !_____!           are welcome to redistribute it under certain  
2018-12-20T21:58:34Z INFO - Suite server: url=http://e1447d2a3cf9:43059/ pid=65
2018-12-20T21:58:34Z INFO - Run: (re)start=0 log=1
2018-12-20T21:58:34Z INFO - Cylc version: 7.7.1-398-g7e472-dirty
2018-12-20T21:58:34Z INFO - Run mode: live
2018-12-20T21:58:34Z INFO - Initial point: 20130808T0000Z
...
...
2018-12-20T21:59:05Z INFO - [bar.20130812T0000Z] -health check settings: submission timeout=None
2018-12-20T21:59:05Z INFO - [bar.20130812T0000Z] -(current:submitted)> started at 2018-12-20T21:59:05Z
2018-12-20T21:59:05Z INFO - [bar.20130812T0000Z] -health check settings: execution timeout=None
2018-12-20T21:59:06Z INFO - [bar.20130812T0000Z] -(current:running)> succeeded at 2018-12-20T21:59:05Z
2018-12-20T21:59:06Z INFO - Suite shutting down - AUTOMATIC
2018-12-20T21:59:06Z INFO - DONE
```

In the terminal where `docker-compose` is running, you should see `supervisor`
"complaining" about PID's changing. Those are Cylc's processes spawning new processes
and fiddling with the current PID. That's expected, and normal.

```bash
cylc_1  | 2018-12-20 21:58:35,627 INFO reaped unknown pid 119
cylc_1  | 2018-12-20 21:58:38,610 INFO reaped unknown pid 194
cylc_1  | 2018-12-20 21:58:41,640 INFO reaped unknown pid 270
cylc_1  | 2018-12-20 21:58:41,653 INFO reaped unknown pid 271
cylc_1  | 2018-12-20 21:58:44,648 INFO reaped unknown pid 401
cylc_1  | 2018-12-20 21:58:44,667 INFO reaped unknown pid 402
cylc_1  | 2018-12-20 21:58:47,656 INFO reaped unknown pid 532
cylc_1  | 2018-12-20 21:58:47,663 INFO reaped unknown pid 533
cylc_1  | 2018-12-20 21:58:50,644 INFO reaped unknown pid 663
cylc_1  | 2018-12-20 21:58:50,659 INFO reaped unknown pid 664
cylc_1  | 2018-12-20 21:58:53,663 INFO reaped unknown pid 795
cylc_1  | 2018-12-20 21:58:53,679 INFO reaped unknown pid 794
cylc_1  | 2018-12-20 21:58:56,683 INFO reaped unknown pid 926
cylc_1  | 2018-12-20 21:58:56,683 INFO reaped unknown pid 925
cylc_1  | 2018-12-20 21:58:59,669 INFO reaped unknown pid 1057
cylc_1  | 2018-12-20 21:58:59,699 INFO reaped unknown pid 1056
cylc_1  | 2018-12-20 21:59:02,692 INFO reaped unknown pid 1187
cylc_1  | 2018-12-20 21:59:02,700 INFO reaped unknown pid 1188
cylc_1  | 2018-12-20 21:59:05,642 INFO reaped unknown pid 13
```

Note that if you try running the same suite `five` on `pbs` right after that, it won't work.
Cylc will find the contact file, check, and abort the initialization and it will find that the suite
is already running on `cylc` (these names are generated by `docker-compose`).

But if the suite is not running elsewhere, as the file system is shared through a shared Docker volume,
Cylc should happily start the suite for you.

## Running Cylc with PBS

This repository ships with an example suite that should work on PBS servers. It was adapted
from a test file in the Cylc code repository.

First you need to register this PBS suite.

```bash
$ cylc register pbs1 /home/testuser/suites/pbs1/         
REGISTERED pbs1 -> /home/testuser/suites/pbs1
```

And then finally execute it. 


Checking the output of `qnodes` is recommended, as the `agaveapi/torque` image is not really stable,
and you may need to kick torque a few times, probably `qstart debug@localhost` to change the status
of the `debug` queue.

```bash
$ cylc run --no-detach pbs1
            ._.                                                       
            | |        The Cylc Suite Engine [7.7.1-398-g7e472-dirty] 
._____._. ._| |_____.           Copyright (C) 2008-2018 NIWA          
| .___| | | | | .___|   & British Crown (Met Office) & Contributors.  
| !___| !_! | | !___.  _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
!_____!___. |_!_____!  This program comes with ABSOLUTELY NO WARRANTY;
      .___! |          see `cylc warranty`.  It is free software, you 
      !_____!           are welcome to redistribute it under certain  
2018-12-20T23:05:38Z INFO - Suite server: url=http://903a5fb70dd1:43087/ pid=330
2018-12-20T23:05:38Z INFO - Run: (re)start=0 log=1
2018-12-20T23:05:38Z INFO - Cylc version: 7.7.1-398-g7e472-dirty
2018-12-20T23:05:38Z INFO - Run mode: live
2018-12-20T23:05:38Z INFO - Initial point: 1
2018-12-20T23:05:38Z INFO - Final point: 1
2018-12-20T23:05:38Z INFO - Cold Start 1
2018-12-20T23:05:49Z INFO - [a.1] -submit-num=1, owner@host=pbs
2018-12-20T23:05:50Z INFO - [a.1] -(current:ready) submitted at 2018-12-20T23:05:50Z
2018-12-20T23:05:50Z INFO - [a.1] -health check settings: submission timeout=None
2018-12-20T23:05:51Z INFO - [a.1] -(current:submitted)> started at 2018-12-20T23:05:50Z
2018-12-20T23:05:51Z INFO - [a.1] -health check settings: execution timeout=None
2018-12-20T23:05:52Z INFO - [b.1] -submit-num=1, owner@host=903a5fb70dd1
2018-12-20T23:05:53Z INFO - [client-command] poll_tasks testuser@903a5fb70dd1:cylc-poll 77bb59a4-d01f-40f5-879c-cdc880451cc3
2018-12-20T23:05:53Z INFO - Command succeeded: poll_tasks([u'a'], poll_succ=False)
2018-12-20T23:05:53Z INFO - Processing 1 queued command(s)
	+	poll_tasks([u'a'], poll_succ=False)
2018-12-20T23:05:53Z INFO - [b.1] -(current:ready) submitted at 2018-12-20T23:05:52Z
2018-12-20T23:05:53Z INFO - [b.1] -health check settings: submission timeout=None
2018-12-20T23:05:53Z INFO - [b.1] -(current:submitted)> started at 2018-12-20T23:05:52Z
2018-12-20T23:05:53Z INFO - [b.1] -health check settings: execution timeout=None
2018-12-20T23:05:53Z INFO - [b.1] -(current:running)> succeeded at 2018-12-20T23:05:53Z
2018-12-20T23:05:54Z INFO - [a.1] -(current:running)(polled) started at 2018-12-20T23:05:50Z
2018-12-20T23:06:11Z INFO - [a.1] -(current:running)> succeeded at 2018-12-20T23:06:10Z
2018-12-20T23:06:11Z INFO - Suite shutting down - AUTOMATIC
2018-12-20T23:06:11Z INFO - DONE
```

If you would like to confirm it is running on the PBS box, and not on
the Cylc one, you can use `qstat` in `pbs`.

```bash
$ qstat
Job ID                    Name             User            Time Use S Queue
------------------------- ---------------- --------------- -------- - -----
0.localhost                a.1.pbs1         testuser        00:00:00 C debug
```
