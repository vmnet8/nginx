#!/bin/bash
set -x
alpine_sha (){
    local sha
    alpine_repo=$1

    sha=$(docker image history $1 |awk '{print$1}' |tail -2 |head -1)
    #alpine_sha=$(docker image history $1 |awk '{print$1}' |tail -2 |head -1)
    #echo $alpine_sha
    echo $sha
}

nginx_sha (){
    local nginx_repo=$1

    nginx_sha=$(docker image history $1 |awk '{print$1}' |tail -2 |head -1)
    echo $nginx_sha
}

compare (){
    if [ $1 != $2 ]
    then
        echo true
    else
        echo false
    fi
}


alpine_sha "vmnet8/alpine:latest"
#nginx_sha vmnet8/nginx-tags:alpine-x86
#compare alpine_sha "treehouses/alpine:3.11" nginx_sha "treehouses/nginx:latest"
