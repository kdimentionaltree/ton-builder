#!/bin/bash
set -e

mkdir -p build

docker build -t tonlib-build-ubuntu-22 -f ubuntu-22.Dockerfile .
CONTAINER_ID=$(docker create tonlib-build-ubuntu-22)
docker cp ${CONTAINER_ID}:/ton/build/tonlib/libtonlibjson.so.0.5 build/libtonlibjson.ubuntu22.so
docker container rm ${CONTAINER_ID}
