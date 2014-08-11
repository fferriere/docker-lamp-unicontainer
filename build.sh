#!/bin/bash

MY_PATH=$(dirname $(realpath $0))

. $MY_PATH"/container-name.conf"

docker build -t $CONTAINER_NAME $MY_PATH/.