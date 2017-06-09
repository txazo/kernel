#!/bin/bash
#
# Usage: Start Hadoop Cluster

# master
cd /usr/local/hadoop
bin/hdfs namenode -format hadoop-cluster
sbin/start-dfs.sh
sbin/start-yarn.sh
sbin/mr-jobhistory-daemon.sh --config etc/hadoop start historyserver

# NameNode:                     http://192.168.99.100:50070
# ResourceManager:              http://192.168.99.100:8088
# MapReduce JobHistory Server:  http://192.168.99.100:19888
