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

FROM ubuntu:16.04

MAINTAINER Bruno P. Kinoshita <brunodepaulak@yahoo.com.br>

# A docker container with Cylc installed.

# Install dependencies with apt and pip

RUN apt-get update && apt-get --no-install-recommends -y install \
		at \
		build-essential \
		git \
		graphviz graphviz-dev libgraphviz-dev \
		heirloom-mailx \
		pkg-config \
		python-gtk2-dev \
		python-pip \
                python-wheel \
		python-pygraphviz \
		python python-dev python-pip \
		python-setuptools \
		sqlite \
		time \
		texlive-latex-base \
	&& pip install \
		Jinja2 \
		pycodestyle \
		pyopenssl

VOLUME "/opt/cylc" "/tmp" "/run" "/var/run"
WORKDIR "/opt/cylc"

# Add Cylc utilities to the PATH environment variable

ENV PATH /opt/cylc/bin:/usr/bin/:$PATH

# Set cylc as entrypoint, so that the container can be run as though it were
# actually the cylc command

ENTRYPOINT ["cylc"]
