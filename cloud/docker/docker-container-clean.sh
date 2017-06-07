#!/bin/bash

docker ps -a | awk '{print $1}' | while read cid
do
    if [ ${cid} != 'CONTAINER' ]; then
       docker stop ${cid}
       docker rm -f ${cid}
    fi
done
