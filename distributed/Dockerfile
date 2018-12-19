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

FROM kinow/cylc-standalone:0.1

MAINTAINER Bruno P. Kinoshita <brunodepaulak@yahoo.com.br>

# A docker container with Cylc dependencies and OpenSSH server installed.

# Install dependencies with apt and pip

RUN apt-get update && apt-get --no-install-recommends -y install \
        inetutils-ping \
        iproute2 \
    && pip install \
        pycodestyle \
        pyopenssl

# Install and set up SSH server

RUN apt-get update && apt-get --no-install-recommends -y install \
    openssh-server \
    && rm -rf /var/lib/apt/lists/*
RUN sed -i /etc/ssh/sshd_config \
    -e 's/.*PermitRootLogin.*/PermitRootLogin yes/' \
    -e 's/.*RSAAuthentication.*/RSAAuthentication yes/'  \
    -e 's/.*PasswordAuthentication.*/PasswordAuthentication no/' \
    -e 's/.*SyslogFacility.*/SyslogFacility AUTH/' \
    -e 's/.*LogLevel.*/LogLevel INFO/' \
    && mkdir /var/run/sshd

# Copy SSH keys

WORKDIR /root/.ssh

COPY id_rsa /root/.ssh/id_rsa
COPY id_rsa.pub /root/.ssh/id_rsa.pub
COPY config /root/.ssh/config

RUN chmod 0600 /root/.ssh/id_rsa \
    && chmod 0600 /root/.ssh/id_rsa.pub

VOLUME "/opt/cylc" "/tmp" "/run" "/var/run"
WORKDIR "/opt/cylc"

# Add Cylc utilities to the PATH environment variable

ENV PATH /opt/cylc/bin:/usr/bin/:$PATH

RUN echo "export PATH=$PATH" >> /etc/environment

COPY setup-sshd /usr/bin/setup-sshd

EXPOSE 22

ENTRYPOINT ["setup-sshd"]
