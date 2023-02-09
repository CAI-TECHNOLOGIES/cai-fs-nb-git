ARG ROOT_CONTAINER=ubuntu:focal-20200703@sha256:d5a6519d9f048100123c568eb83f7ef5bfcad69b01424f420f17c932b00dea76

ARG BASE_CONTAINER=$ROOT_CONTAINER

# Build required libraries
FROM $BASE_CONTAINER

RUN apt-get update && \
    apt-get install -yq --no-install-recommends \
    build-essential \
    python3-dev \
    python3-pip \
    wget

RUN python3 -m pip install -U \
    setuptools \
    jupyter_packaging \
    jupyterlab==3.2.0b0 \
    --no-cache-dir

ENV PATH /opt/node-v14.20.0-linux-x64/bin:$PATH
RUN cd /tmp && wget http://nodejs.org/dist/v14.20.0/node-v14.20.0-linux-x64.tar.gz
RUN tar -xzf /tmp/node-v14.20.0-linux-x64.tar.gz -C /opt && \
    rm /tmp/node-v14.20.0-linux-x64.tar.gz

RUN npm i -g yarn

COPY . cai-fs-nb-git
RUN cd cai-fs-nb-git && \
    python3 setup.py sdist --format=gztar