#!/bin/bash

BASE_NAME=$(basename $0)
DIR_NAME=$(cd $(dirname $0) ; pwd)

cd ${DIR_NAME}

docker stop $(docker ps -q)
docker system prune
docker rmi $(docker images -q)
