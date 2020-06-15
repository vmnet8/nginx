#!/bin/bash
#set -x
is_base (){
    local base_sha    # alpine
    local image_sha   # nginx
    base_repo=$1
    image_repo=$2
    docker pull $1 &>/dev/null
    base_sha=$(docker image history $1 |awk '{print$1}' |tail -2 |head -1)
    echo $base_sha
    docker pull $2 &>/dev/null
    image_sha=$(docker image history $2 |awk '{print$1}' |tail -2 |head -1)
    echo $image_sha

    if [ $base_sha != $image_sha ]
    then
        echo true
    else
        echo false
    fi
}

#is_base "vmnet8/alpine:latest"  "vmnet8/nginx-tags:alpine-x86"
#is_base "treehouses/alpine:3.11"  "treehouses/nginx:latest"
