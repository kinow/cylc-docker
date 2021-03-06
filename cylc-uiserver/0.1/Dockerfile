# The MIT License (MIT)
#
# Copyright (c) 2020 Bruno P. Kinoshita
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and
# associated documentation files (the "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the
# following conditions:
#
# The above copyright notice and this permission notice shall be included in all copies or substantial
# portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT
# LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO
# EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
# IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR
# THE USE OR OTHER DEALINGS IN THE SOFTWARE.

FROM python:3.7.6-alpine3.11

ARG cylc_docker_owner=kinow
ARG cylc_docker_version=0.1

LABEL maintainer=${cylc_docker_owner}
LABEL version=${cylc_docker_version}

# A docker container with cylc-flow installed.
# With additional contributions from Alan Christie (alanbchritie).
# see: https://github.com/alanbchristie/cylc-docker/blob/master/docker/Dockerfile

# Install dependencies with apk and pip

RUN apk update && \
    apk add --no-cache \
    bash \
    libffi-dev \
    libressl-dev \
    libzmq \
    linux-pam \
    nodejs \
    npm \
    zeromq-dev && \
    apk add --no-cache --virtual build-dependencies \
    gcc \
    git \
    g++ \
    python3-dev && \
    pip install --no-cache-dir \
    "cylc-uiserver[all]==${cylc_docker_version}" \
    jupyterhub-dummyauthenticator && \
    apk del build-dependencies

RUN npm i -g configurable-http-proxy

# Add a non-root user

ENV USER_NAME cylc
ENV USER_GROUP cylc
ENV USER_ROOT /home/${USER_NAME}
ENV USER_ID 6000
RUN addgroup -g 1000 cylc && \
    adduser --shell /bin/bash --uid ${USER_ID} -D --home ${USER_ROOT} ${USER_NAME} -G ${USER_GROUP}

WORKDIR ${USER_ROOT}
COPY docker-entrypoint.sh ${USER_ROOT}/
COPY jupyterhub_config.py ${USER_ROOT}/
ADD https://github.com/cylc/cylc-ui/releases/download/0.1/cylc-ui-0.1-dist.zip ${USER_ROOT}/cylc-ui-0.1-dist.zip

RUN mkdir cylc-ui-0.1-dist && unzip cylc-ui-0.1-dist.zip -d cylc-ui-0.1-dist

# Copy the examples in
COPY cylc-suites cylc-suites

# Change ownerships...
# and permissions, sudoers etc...
RUN chown -R ${USER_NAME}:${USER_GROUP} ${USER_ROOT} && \
    chown -R ${USER_NAME}:${USER_GROUP} /tmp && \
    chmod +x docker-entrypoint.sh

# we can now switch to our non-root user...
USER ${USER_ID}
ENV HOME ${USER_ROOT}
ENV PYTHONHTTPSVERIFY 0
ENV PYTHONWARNINGS ignore

RUN cylc check-software 2> /dev/null && \
    cylc version && \
    cylc-uiserver -h && \
    cylc register five cylc-suites/five && \
    cylc register families2 cylc-suites/families2 && \
    cylc register complex cylc-suites/complex

ENTRYPOINT ["jupyterhub"]
