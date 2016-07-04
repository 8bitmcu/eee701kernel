#!/bin/bash
KERNEL=linux-4.7-rc5
VERSION=4.7.0-rc5

docker build -t kerneli .
docker run  -e KERNEL=$KERNEL \
            -e VERSION=$VERSION \
            -v ~/eee701kernel:/host \
            -ti kerneli \
            bash /host/script.sh
            # ls /host
