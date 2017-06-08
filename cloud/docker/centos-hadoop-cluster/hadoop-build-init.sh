#!/bin/bash
#
# Usage: Hadoop Cluster Image build init

source ./hadoop-cluster-env.sh

mkdir -p repo
wget -O repo/CentOS-Base.repo ${yumMirrorURL}

if [ ! -f ~/.ssh/id_rsa ]; then
    ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
fi

if [ ! -f ssh/id_rsa ]; then
    mkdir -p ssh
    cp ~/.ssh/id_rsa ~/.ssh/id_rsa.pub ssh/
fi
