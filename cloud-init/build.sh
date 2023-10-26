#! /bin/bash

set -euo pipefail
cd "$(dirname "${0}")"

while read -r server; do
    export MACHINE_NAME="${server}"
    docker compose -f network-generator.yml up
    docker compose -f user-data-generator.yml up
done < ../gateway-list

while read -r server; do
    export MACHINE_NAME="${server}"
    docker compose -f user-data-generator.yml up
done < ../cluster-list

exit 0
