#!/bin/bash
#
# Usage: Build Hadoop Cluster Image

source ./hadoop-cluster-env.sh

source ./hadoop-build-init.sh

docker build -t ${imageName} .
