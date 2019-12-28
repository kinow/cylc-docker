# The MIT License (MIT)
#
# Copyright (c) 2018 Bruno P. Kinoshita
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

FROM python:3.8.1-alpine11

MAINTAINER Bruno P. Kinoshita <brunodepaulak@yahoo.com.br>

# A docker container with cylc-flow installed.

# Install dependencies with apk and pip

WORKDIR /opt/

RUN apk update && \
    apk add --no-cache \
    bash \
    libzmq \
    zeromq-dev && \
    apk add --no-cache --virtual build-dependencies \
    gcc \
    git \
    g++ \
    python3-dev && \
    pip install --no-cache-dir \
    git+https://github.com/cylc/cylc-flow@8.0a1#egg=cylc-flow && \
    apk del build-dependencies

RUN cd cylc-flow && \
    apt install .[all]

# Add a non-root user

RUN addgroup -g 1000 cylc && \
    adduser -u 1000 -D --home "/home/cylc" cylc -G cylc

# Add a sample suite

RUN mkdir -p /home/cylc/cylc-run/hello && \
    echo -e "\
[scheduling]\n\
[[dependencies]]\n\
graph = "Hello"\n\
\n\
[runtime]\n\
[[hello]]\n\
script = 'sleep 10; echo Hello world!'\n\
" > /home/cylc/cylc-run/hello/suite.rc && \
    chown -R cylc:cylc /home/cylc

USER cylc

CMD ["bash"]
