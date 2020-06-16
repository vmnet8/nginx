#!/bin/bash
#set -x
get_sha(){
    repo=$1
    docker pull $1 &>/dev/null
    #sha=$(docker image inspect $1 |jq .[0].RootFS.Layers |grep sha)
    sha=$(docker image inspect $1 | jq --raw-output '.[0].RootFS.Layers|.[]')   # [0] means first element of list,[]means all the elments of lists
    echo $sha
    #read -a base_sha <<< $base_sha
    #sha_arr=($sha)
    #echo "sha is $sha_arr"

}
is_base (){
    local base_sha    # alpine
    local image_sha   # nginx
    base_repo=$1
    image_repo=$2
    base_sha=$(get_sha $1)
    echo $base_sha
    image_sha=$(get_sha $2)
    echo $image_sha

    #found="true"
    found=0
    for i in $base_sha; do
        for j in $image_sha; do
            if [ "$i" = "$j" ]; then
                echo "no change, same base image: $i"
                #found="false"
                found=1
                break
            fi
        done
    done
    echo "$found"

    #for i in ${image_sha}
    #do
    #    echo $i
    #done
    #diff=()
    #for i in "${base_sha[0]}"; do
    #for i in "${base_sha[@]}"; do
    # for j in "${image_sha[@]}"; do
    #     echo $j
    #     if [ $j == ${base_sha[0]} ]; then
    #         diff=$j
    #         echo $diff
    #     fi
    # done
    #done
    #    [[ -n $skip ]] || diff+=("$i")
    #done
    #if [ ${base_sha[*]} != ${image_sha[*]} ]
    #then
     #   echo true
    #else
     #   echo false
    #fi
}

#is_base "vmnet8/alpine:latest"  "vmnet8/nginx-tags:alpine-x86"
flag=$(is_base "vmnet8/alpine:latest"  "vmnet8/nginx-tags:alpine-x86")
echo $flag
#is_base "treehouses/nginx:1.18" "treehouses/turtleblocksjs-tags:x86"
#is_base "treehouses/alpine:3.11"  "treehouses/nginx:latest"
#get_sha "treehouses/nginx:latest"
#is_base
