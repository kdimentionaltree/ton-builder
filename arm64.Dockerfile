FROM ubuntu:20.04

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get -y install tzdata

RUN apt install -y build-essential cmake clang openssl libssl-dev zlib1g-dev gperf wget git curl libreadline-dev ccache libmicrohttpd-dev

# build tonlib
WORKDIR /

# remove /tree/<commit> to build master branch
RUN git clone --recurse-submodules https://github.com/ton-blockchain/ton.git

# fix lib version and patch logging
WORKDIR /ton
RUN mkdir /ton/build
WORKDIR /ton/build
ENV CC clang
ENV CXX clang++
RUN cmake -DCMAKE_BUILD_TYPE=Release .. -DTON_ARCH=
RUN cmake --build . -j$(nproc) --target tonlibjson
