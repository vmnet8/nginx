#!/bin/bash
x86=$1
rpi=$2
#arm64=$3
docker build -t $1 -f Dockerfile
docker build -t $2 -f Dockerifle.rpi
#docker build -t $3 -f .
