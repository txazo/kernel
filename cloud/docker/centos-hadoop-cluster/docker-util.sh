#!/bin/bash
#
# Usage: Docker Util

function cleanContainer() {
    docker ps -a | awk 'NR > 1 {print $1}' | while read cid
    do
        docker stop ${cid} >/dev/null 2>&1
        docker rm -f ${cid} >/dev/null 2>&1
        echo "Clean Container: ${cid}"
    done
}
