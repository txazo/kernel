#!/bin/bash

yum install -y pipework

git clone https://github.com/jpetazzo/pipework.git
cp pipework/pipework /usr/local/bin/
rm -rf pipework

# 安装pipework

pipework bridge0 master 192.168.99.10/24
pipework bridge0 slave1 192.168.99.11/24
pipework bridge0 slave2 192.168.99.12/24
