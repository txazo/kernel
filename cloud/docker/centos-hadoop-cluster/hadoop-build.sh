#!/bin/bash
#
# Usage: Build Hadoop Cluster Image

source ./hadoop-cluster-conf.sh

source ./hadoop-build-init.sh

image=`getProperty 'image'`
docker build -t $image .
