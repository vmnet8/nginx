#!/bin/bash
rpi=$1
docker build -t $1 -f Dockerifle.rpi .
