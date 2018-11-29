# Source: https://medium.com/@greut/minimal-python-deployment-on-docker-with-uwsgi-bc5aa89b3d35
# Adapted to run Python3 and compatible uwsgi.

FROM python:2.7.15-alpine3.8

EXPOSE 3031
VOLUME /opt/cylc
WORKDIR /opt/cylc

RUN apk add --no-cache \
        uwsgi-python

# need at least one folder of the app returns only 404
RUN mkdir /root/cylc-run

# https://uwsgi-docs.readthedocs.io/en/latest/WSGIquickstart.html

CMD [ "uwsgi", "--socket", "0.0.0.0:3031", \
# need root as there are no other places with cylc-run dirs
#               "--uid", "uwsgi", \
               "--uid", "root", \
               "--protocol", "uwsgi", \
               "--plugin", "python", \
               "--need-app", \
# cherrypy uses threads
               "--enable-threads", \
#               "--manage-script-name", \
               "--pythonpath", "/opt/cylc/lib", \
# where to find the wsgi callable
               "--wsgi-file", "/opt/cylc/bin/cylc-review" ]

