# The MIT License (MIT)
# 
# Copyright (c) 2016 Bruno P. Kinoshita
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

RUN apt-get update &&  apt-get -y install \
		at \
		build-essential \
		git \
		graphviz graphviz-dev libgraphviz-dev \
		heirloom-mailx \
		pkg-config \
		python-gtk2-dev \
		python-pip \
		python-pygraphviz \
		python python-dev python-pip \
		sqlite \
		texlive-latex-base && \
	pip install \
		Jinja2 \
		pycodestyle \
		pyopenssl

# Retrieve copy of Cylc

WORKDIR /opt

RUN git clone https://github.com/cylc/cylc.git && \
	cd cylc && \
	git checkout 7.7.2

# Add Cylc utilities to the PATH environment variable

ENV PATH /opt/cylc/bin:$PATH

# Set cylc as entrypoint, so that the container can be run as though it were
# actually the cylc command

WORKDIR /opt/cylc

ENTRYPOINT ["cylc"]
