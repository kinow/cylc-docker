# Standalone Cylc

In this standalone example, Cylc will both schedule and execute all tasks.

## Create base image

Change directory to the `standalone` folder of this repository, so that you have the `Dockerfile`
configuration file in the working directory. Then open a terminal and execute the following
command.

```bash
	user@localhost:~$ docker build --tag cylc-docker .
```

This will create a container with Ubuntu 16.04, python 2.7, Cylc dependencies, and
a version of Cylc included under `/opt/cylc/`. The final commands to create the
base image will run `cylc check-software` and `cylc version`. So if everything went well,
your last log line should contain something similar to `7.7.1`, or another Cylc version.

## Start a container with Cylc

You can start a container with a terminal session to run and test cylc with the following
command.

```bash
	user@localhost:~$ docker run --rm -it cylc-docker
```

You should be able to run a simple suite with the following commands as well.

```bash
	root@f6694cdd3444:/# cylc validate /opt/cylc/etc/examples/tutorial/oneoff/basic/
	Valid for cylc-7.7.1
	root@f6694cdd3444:/# cylc register /opt/cylc/etc/examples/tutorial/oneoff/basic/
	REGISTER /opt/cylc/etc/examples/tutorial/oneoff/basic/
	root@f6694cdd3444:/# cylc start --non-daemon --debug /opt/cylc/etc/examples/tutorial/oneoff/basic/

	            ._.                                                       
	            | |                 The Cylc Suite Engine [7.7.1]         
	._____._. ._| |_____.           Copyright (C) 2008-2018 NIWA          
	| .___| | | | | .___|  _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
	| !___| !_! | | !___.  This program comes with ABSOLUTELY NO WARRANTY;
	!_____!___. |_!_____!  see `cylc warranty`.  It is free software, you 
	      .___! |           are welcome to redistribute it under certain  
	      !_____!                conditions; see `cylc conditions`.       
	2018-07-14T09:55:55Z INFO - Suite starting: server=f6694cdd3444:43043 pid=73
	2018-07-14T09:55:55Z INFO - Cylc version: 7.7.1
	2018-07-14T09:55:55Z INFO - Run mode: live
	2018-07-14T09:55:55Z INFO - Initial point: 1
	2018-07-14T09:55:55Z INFO - Final point: 1
	2018-07-14T09:55:55Z INFO - Cold Start 1
	2018-07-14T09:55:55Z DEBUG - [hello.1] -released to the task pool
	2018-07-14T09:55:55Z DEBUG - BEGIN TASK PROCESSING
	2018-07-14T09:55:55Z DEBUG - [hello.1] -waiting => queued
	2018-07-14T09:55:55Z DEBUG - 1 task(s) de-queued
	2018-07-14T09:55:55Z INFO - [hello.1] -submit-num=1, owner@host=localhost
	2018-07-14T09:55:55Z DEBUG - [hello.1] -queued => ready
	2018-07-14T09:55:55Z DEBUG - END TASK PROCESSING (took 0.0114171504974 seconds)
	2018-07-14T09:55:56Z DEBUG - ['cylc', 'jobs-submit', '--debug', '--', '/opt/cylc/etc/examples/tutorial/oneoff/basic/log/job', '1/hello/01']
	2018-07-14T09:55:56Z DEBUG - [client-connect] root@f6694cdd3444:cylc-message privilege='full-control' ffefeb1c-f425-4fd8-9175-182045368134
	2018-07-14T09:55:56Z INFO - [client-command] put_messages root@f6694cdd3444:cylc-message ffefeb1c-f425-4fd8-9175-182045368134
	2018-07-14T09:55:56Z DEBUG - [jobs-submit cmd] cylc jobs-submit --debug -- /opt/cylc/etc/examples/tutorial/oneoff/basic/log/job 1/hello/01
		[jobs-submit ret_code] 0
		[jobs-submit out]
		[TASK JOB SUMMARY]2018-07-14T09:55:56Z|1/hello/01|0|127
		[TASK JOB COMMAND]2018-07-14T09:55:56Z|1/hello/01|[STDOUT] 127
	2018-07-14T09:55:56Z INFO - [hello.1] -(current:ready) submitted at 2018-07-14T09:55:56Z
	2018-07-14T09:55:56Z INFO - [hello.1] -job[01] submitted to localhost:background[127]
	2018-07-14T09:55:56Z DEBUG - [hello.1] -ready => submitted
	2018-07-14T09:55:56Z INFO - [hello.1] -health check settings: submission timeout=None
	2018-07-14T09:55:56Z DEBUG - BEGIN TASK PROCESSING
	2018-07-14T09:55:56Z DEBUG - 0 task(s) de-queued
	2018-07-14T09:55:56Z DEBUG - [hello.1] -forced spawning
	2018-07-14T09:55:56Z DEBUG - END TASK PROCESSING (took 0.00108695030212 seconds)
	2018-07-14T09:55:56Z INFO - [hello.1] -(current:submitted)> started at 2018-07-14T09:55:56Z
	2018-07-14T09:55:56Z DEBUG - [hello.1] -submitted => running
	2018-07-14T09:55:56Z INFO - [hello.1] -health check settings: execution timeout=None
	2018-07-14T09:55:57Z DEBUG - BEGIN TASK PROCESSING
	2018-07-14T09:55:57Z DEBUG - 0 task(s) de-queued
	2018-07-14T09:55:57Z DEBUG - END TASK PROCESSING (took 0.000463008880615 seconds)
	2018-07-14T09:56:06Z DEBUG - [client-connect] root@f6694cdd3444:cylc-message privilege='full-control' bf30eb10-073d-4d28-8636-bb115efa2a1b
	2018-07-14T09:56:06Z INFO - [client-command] put_messages root@f6694cdd3444:cylc-message bf30eb10-073d-4d28-8636-bb115efa2a1b
	2018-07-14T09:56:06Z INFO - [hello.1] -(current:running)> succeeded at 2018-07-14T09:56:06Z
	2018-07-14T09:56:06Z DEBUG - [hello.1] -running => succeeded
	2018-07-14T09:56:06Z INFO - Suite shutting down - AUTOMATIC
	2018-07-14T09:56:07Z INFO - DONE
```
