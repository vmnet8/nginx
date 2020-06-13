#!/bin/bash
set -x
alpine_sha (){
    local alpine_repo=$1

    alpine_sha=$(docker image history $1 |awk '{print$1}' |tail -2 |head -1)
    echo $alpine_sha
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


#alpine_sha "treehouses/alpine:3.11"
#nginx_sha treehouses/nginx:latest
#compare alpine_sha "treehouses/alpine:3.11" nginx_sha "treehouses/nginx:latest"
