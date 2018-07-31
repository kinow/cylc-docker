# Standalone Cylc

In this standalone example, one Cylc container will both schedule and execute all tasks.

## Build the image

The name of the tag used to build the container is important if you intend
to run the container as a command.

```bash
$ docker build --tag cylc .
```

This will create a container with Ubuntu 16.04, python 2.7, Cylc dependencies, and
a version of Cylc included under `/opt/cylc/`.

This container can be run as though it were the real cylc command, as will be shown
in the next section.

## Running commands

You can run this container as if it were the cylc command.

```bash
$ docker run cylc check-software
Checking your software...

Individual results:
stty: 'standard input': Inappropriate ioctl for device
=============================================================================
stty: 'standard input': Inappropriate ioctl for device
Package (version requirements)                        Outcome (version found)
stty: 'standard input': Inappropriate ioctl for device
=============================================================================
stty: 'standard input': Inappropriate ioctl for device
                             *REQUIRED SOFTWARE*                             
stty: 'standard input': Inappropriate ioctl for device
Python (2.6+, <3)...................FOUND & min. version MET (2.7.12.final.0)

stty: 'standard input': Inappropriate ioctl for device
      *OPTIONAL SOFTWARE for the GUI & dependency graph visualisation*      
/usr/lib/python2.7/dist-packages/gtk-2.0/gtk/__init__.py:57: GtkWarning: could not open display
  warnings.warn(str(e), _gtk.Warning)
stty: 'standard input': Inappropriate ioctl for device
Python:pygtk (2.0+).........................FOUND & min. version MET (2.24.0)
stty: 'standard input': Inappropriate ioctl for device
graphviz (any).................................................FOUND (2.38.0)
stty: 'standard input': Inappropriate ioctl for device
Python:pygraphviz (any).........................................FOUND (1.3.1)

stty: 'standard input': Inappropriate ioctl for device
                 *OPTIONAL SOFTWARE for the HTML User Guide*                 
stty: 'standard input': Inappropriate ioctl for device
ImageMagick (any)...............................................NOT FOUND (-)

stty: 'standard input': Inappropriate ioctl for device
           *OPTIONAL SOFTWARE for the HTTPS communications layer*           
stty: 'standard input': Inappropriate ioctl for device
Python:urllib3 (any)............................................NOT FOUND (-)
stty: 'standard input': Inappropriate ioctl for device
Python:OpenSSL (any)...........................................FOUND (18.0.0)
stty: 'standard input': Inappropriate ioctl for device
Python:requests (2.4.2+)........................................NOT FOUND (-)

stty: 'standard input': Inappropriate ioctl for device
                *OPTIONAL SOFTWARE for the LaTeX User Guide*                
stty: 'standard input': Inappropriate ioctl for device
TeX:framed (any)................................................NOT FOUND (-)
stty: 'standard input': Inappropriate ioctl for device
TeX (3.0+)..............................FOUND & min. version MET (3.14159265)
stty: 'standard input': Inappropriate ioctl for device
TeX:preprint (any)..............................................NOT FOUND (-)
stty: 'standard input': Inappropriate ioctl for device
TeX:tex4ht (any)................................................NOT FOUND (-)
stty: 'standard input': Inappropriate ioctl for device
TeX:tocloft (any)...............................................NOT FOUND (-)
stty: 'standard input': Inappropriate ioctl for device
TeX:texlive (any)...............................................NOT FOUND (-)
stty: 'standard input': Inappropriate ioctl for device
=============================================================================

Summary:
stty: 'standard input': Inappropriate ioctl for device
                        ****************************                        
stty: 'standard input': Inappropriate ioctl for device
                            Core requirements: ok                            
stty: 'standard input': Inappropriate ioctl for device
                         Full-functionality: not ok                         
stty: 'standard input': Inappropriate ioctl for device
                        ****************************  
```

And you can even run suites.

```bash
$ docker run cylc validate /opt/cylc/etc/examples/tutorial/oneoff/basic/
Valid for cylc-7.7.2
$ docker run cylc register /opt/cylc/etc/examples/tutorial/oneoff/basic/
REGISTER /opt/cylc/etc/examples/tutorial/oneoff/basic/
$ docker run cylc start --non-daemon --debug /opt/cylc/etc/examples/tutorial/oneoff/basic/
            ._.                                                       
            | |                 The Cylc Suite Engine [7.7.2]         
._____._. ._| |_____.           Copyright (C) 2008-2018 NIWA          
| .___| | | | | .___|  _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
| !___| !_! | | !___.  This program comes with ABSOLUTELY NO WARRANTY;
!_____!___. |_!_____!  see `cylc warranty`.  It is free software, you 
      .___! |           are welcome to redistribute it under certain  
      !_____!                conditions; see `cylc conditions`.       
2018-07-30T12:10:32Z INFO - Suite starting: server=3714d1a17999:43040 pid=1
2018-07-30T12:10:32Z INFO - Cylc version: 7.7.2
2018-07-30T12:10:32Z INFO - Run mode: live
2018-07-30T12:10:32Z INFO - Initial point: 1
2018-07-30T12:10:32Z INFO - Final point: 1
2018-07-30T12:10:32Z INFO - Cold Start 1
2018-07-30T12:10:32Z DEBUG - [hello.1] -released to the task pool
2018-07-30T12:10:32Z DEBUG - BEGIN TASK PROCESSING
2018-07-30T12:10:32Z DEBUG - [hello.1] -waiting => queued
2018-07-30T12:10:32Z DEBUG - 1 task(s) de-queued
2018-07-30T12:10:32Z INFO - [hello.1] -submit-num=1, owner@host=localhost
2018-07-30T12:10:32Z DEBUG - [hello.1] -queued => ready
2018-07-30T12:10:32Z DEBUG - END TASK PROCESSING (took 0.00642895698547 seconds)
2018-07-30T12:10:32Z DEBUG - ['cylc', 'jobs-submit', '--debug', '--', '/opt/cylc/etc/examples/tutorial/oneoff/basic/log/job', '1/hello/01']
2018-07-30T12:10:33Z DEBUG - [client-connect] root@3714d1a17999:cylc-message privilege='full-control' 7b05596a-5971-4733-82de-28528f702ff0
2018-07-30T12:10:33Z INFO - [client-command] put_messages root@3714d1a17999:cylc-message 7b05596a-5971-4733-82de-28528f702ff0
2018-07-30T12:10:33Z DEBUG - [jobs-submit cmd] cylc jobs-submit --debug -- /opt/cylc/etc/examples/tutorial/oneoff/basic/log/job 1/hello/01
	[jobs-submit ret_code] 0
	[jobs-submit out]
	[TASK JOB SUMMARY]2018-07-30T12:10:32Z|1/hello/01|0|61
	[TASK JOB COMMAND]2018-07-30T12:10:32Z|1/hello/01|[STDOUT] 61
2018-07-30T12:10:33Z INFO - [hello.1] -(current:ready) submitted at 2018-07-30T12:10:32Z
2018-07-30T12:10:33Z INFO - [hello.1] -job[01] submitted to localhost:background[61]
2018-07-30T12:10:33Z DEBUG - [hello.1] -ready => submitted
2018-07-30T12:10:33Z INFO - [hello.1] -health check settings: submission timeout=None
2018-07-30T12:10:33Z DEBUG - BEGIN TASK PROCESSING
2018-07-30T12:10:33Z DEBUG - 0 task(s) de-queued
2018-07-30T12:10:33Z DEBUG - [hello.1] -forced spawning
2018-07-30T12:10:33Z DEBUG - END TASK PROCESSING (took 0.000992059707642 seconds)
2018-07-30T12:10:33Z INFO - [hello.1] -(current:submitted)> started at 2018-07-30T12:10:33Z
2018-07-30T12:10:33Z DEBUG - [hello.1] -submitted => running
2018-07-30T12:10:33Z INFO - [hello.1] -health check settings: execution timeout=None
2018-07-30T12:10:34Z DEBUG - BEGIN TASK PROCESSING
2018-07-30T12:10:34Z DEBUG - 0 task(s) de-queued
2018-07-30T12:10:34Z DEBUG - END TASK PROCESSING (took 0.000984191894531 seconds)
2018-07-30T12:10:43Z DEBUG - [client-connect] root@3714d1a17999:cylc-message privilege='full-control' 524d658e-9932-4135-9523-3c2ace3990cf
2018-07-30T12:10:43Z INFO - [client-command] put_messages root@3714d1a17999:cylc-message 524d658e-9932-4135-9523-3c2ace3990cf
2018-07-30T12:10:43Z INFO - [hello.1] -(current:running)> succeeded at 2018-07-30T12:10:43Z
2018-07-30T12:10:43Z DEBUG - [hello.1] -running => succeeded
2018-07-30T12:10:43Z INFO - Suite shutting down - AUTOMATIC
2018-07-30T12:10:44Z INFO - DONE
$
```

### Running a terminal

If you would like to explore the container contents, and instead of `cylc`,
you preferred to have an entrypoint such as, say, `/bin/bash`, then you would
have to change the container's entrypoint. For example:

```bash
$ docker run -ti --entrypoint /bin/bash cylc
root@1dae549cd8ea:~/.ssh#
```

## License

Licensed under the MIT License.

## References

- [Best practices for writing Dockerfiles](https://docs.docker.com/develop/develop-images/dockerfile_best-practices)
