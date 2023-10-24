#!/bin/bash

set -eu

bash cloud-init/build.sh

if [[ ! -d generated ]];then
    mkdir generated
fi

docker run \
  --rm \
  --privileged \
  -v /dev:/dev \
  -v ${PWD}:/build \
  mkaczanowski/packer-builder-arm:latest \
      init -upgrade packer/build.pkr.hcl

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
            build --var-file=packer/${line}.pkrvars.hcl packer/ \
            -extra-system-packages=ansible
done < ./server-list
