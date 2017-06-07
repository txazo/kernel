#!/bin/bash

# master
cd /usr/local/hadoop
echo "slave1\nslave2" > etc/slaves
bin/hdfs namenode -format hadoop-cluster
