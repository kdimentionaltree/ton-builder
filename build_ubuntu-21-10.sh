#!/bin/bash
set -e

mkdir -p build

docker build -t tonlib-build-ubuntu-21-10 -f ubuntu-21-10.Dockerfile .
CONTAINER_ID=$(docker create tonlib-build-ubuntu-21-10)
docker cp ${CONTAINER_ID}:/ton/build/tonlib/libtonlibjson.so.0.5 build/libtonlibjson.ubuntu21-10.so
docker container rm ${CONTAINER_ID}
