#!/bin/bash
#
# Usage: Start Hadoop Cluster

# master
cd /usr/local/hadoop
bin/hdfs namenode -format hadoop-cluster
sbin/start-dfs.sh
sbin/start-yarn.sh
sbin/mr-jobhistory-daemon.sh --config etc/hadoop start historyserver
