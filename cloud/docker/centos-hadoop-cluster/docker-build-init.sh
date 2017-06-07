#!/bin/bash

if [ ! -f repo/CentOS7-Base-163.repo ]; then
    mkdir -p repo
    wget -O repo/CentOS7-Base-163.repo http://mirrors.aliyun.com/repo/Centos-7.repo
fi

if [ ! -f ~/.ssh/id_rsa ]; then
    ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
fi

if [ ! -f ssh/id_rsa ]; then
    mkdir -p ssh
    cp ~/.ssh/id_rsa ~/.ssh/id_rsa.pub ssh/
fi
