#!/bin/bash

set -eu

bash cloud-init/build.sh

if [[ ! -d generated ]];then
    mkdir generated
fi

while read -r line; do
    echo "===================================================="
    echo "= build image a ${line}"
    echo "===================================================="
    docker run \
        --rm \
        --privileged \
        -v /dev:/dev \
        -v ${PWD}:/build \
        mkaczanowski/packer-builder-arm:latest \
            build \
            --var-file=packer/${line}.pkrvars.hcl \
            packer/
done < ./server-list
