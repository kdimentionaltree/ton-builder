#!/bin/bash
set -e

docker buildx use ton-builder

for PLATFORM in amd64 arm64
do
    echo "Building ${PLATFORM} tonlibjson"
    docker buildx build --platform=linux/${PLATFORM} --progress=plain --load . -t tonlib-build-${PLATFORM} -f ${PLATFORM}.Dockerfile

    if [[ ${PLATFORM} == amd64 ]]
    then
        PLATFORM_EXPORT_NAME=x86_64
    elif [[ ${PLATFORM} == arm64 ]]
    then
        PLATFORM_EXPORT_NAME=aarch64
    fi
    echo "Using export name: ${PLATFORM_EXPORT_NAME}"

    mkdir -p build
    CONTAINER_ID=$(docker create --platform=linux/${PLATFORM} tonlib-build-${PLATFORM})
    docker cp ${CONTAINER_ID}:/ton/build/tonlib/libtonlibjson.so.0.5 build/libtonlibjson.${PLATFORM_EXPORT_NAME}.so
    docker container rm ${CONTAINER_ID}
done
