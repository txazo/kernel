#!/bin/bash
#
# Usage: Hadoop Cluster Environment

# image
imageName="centos-hadoop-cluster"

# container
containerIP="192.168.99.100"

# yum
yumMirrorURL="http://mirrors.163.com/.help/CentOS7-Base-163.repo"

# hdfs
hdfsClusterName="hadoop-cluster"

# network
networkName="hadoop-cluster"
networkSubnet="172.24.0.0/16"

# node
nodeHost=("master" "slave1" "slave2" "slave3")
nodeIP=("172.24.1.10" "172.24.1.11" "172.24.1.12" "172.24.1.13")
nodeSSHPort=(10022 10122 10222 10322)

# master
masterExposePort=(8088 9000 10020 19888 50070 50090)
