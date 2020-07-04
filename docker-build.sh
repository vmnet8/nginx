#!/bin/bash
#set -x
# params:
#    docker_repo=$1  #alpine or vmnet/alpine
#    manifest_tag=$2
#    docker_image=$docker_repo:$manifest_tag
#    arch=$3
#    variant=$4

if [ $# -le 1 ]; then
    echo "missing parameters."
    exit 1
fi

dir=$(dirname $0)
#sha=$($dir/alpine-sha.sh $@)  this function is get alpine:latest sha
sha=$($dir/manifest-alpine-sha.sh $@)
echo $sha
base_image="vmnet8/alpine@$sha"
echo $base_image
arch=$2   # arm arm64 amd64

if [ -n "$sha" ]; then
        timetag=$(date +%Y%m%d%H%M)
        tag=vmnet8/nginx-tags:$arch-$timetag
        #sed "s|{{base_image}}|$base_image|g" Dockerfile.template > /tmp/Dockerfile.$arch
        sed "s|{{base_image}}|$base_image|g" Dockerfile.template > Dockerfile.$arch
        #cat /tmp/Dockerfile.$arch
        docker build -t $tag -f Dockerfile.$arch .
        version=$(docker run -it $tag /bin/sh -c "nginx -v" |awk '{print$3}')
        echo "$arch nginx version is $version"
        docker push $tag
fi

#archs="rpi x86 arm64"
#if [ -n "$sha" ]; then
#    base_image=vmnet8/alpine@$sha
#    echo $base_image
#    for arch in $archs; do
#        tag=vmnet8/nginx-tags:$arch
#        sed "s|{{base_image}}|$base_image|g" Dockerfile.template > /tmp/Dockerfile.$arch
#        #docker build -t $tag -f /tmp/Dockerfile.$arch
#    done
#fi
