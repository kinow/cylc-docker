FROM python:3.7.4-alpine3.10

#RUN apk --no-cache add git

RUN apk add --no-cache --virtual .build-deps gcc musl-dev python3-dev zeromq-dev \
    && pip install --user \
    cython \
    pytest \
    pytest-runner \
    setuptools \
    testfixtures \
    && apk add --no-cache bash openssh

RUN cd /opt/cylc/cylc-flow \
    && pip install --user -e .[all]

# Remove unnecessary build tools, leaving only runtime requirements installed
RUN apk del build-base musl-dev python3-dev zeromq-dev

