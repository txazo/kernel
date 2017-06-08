#!/bin/bash
#
# Usage: Init Hadoop Cluster

hostname=`hostname`

source ./hadoop-cluster-conf.sh

clusterNodes=`getProperty 'clusterNodes'`

if [ $hostname == 'master' ]; then
    cd /usr/local/hadoop
    echo $clusterNodes | awk -F " " '{for (i = 1; i <= NF; i++) {if ($i != "master") {print $i}}}' > etc/hadoop/slaves
    echo -e "slave1\nslave2" > etc/slaves
    hdfsClusterName=`getProperty 'hdfsClusterName'`
    bin/hdfs namenode -format -f $hdfsClusterName
fi

cp /etc/hosts /etc/hosts.tmp
sed -i 's/172\.24\..*/172\.24\.1\.11 master\n172\.24\.1\.12 slave1\n172\.24\.1\.13 slave2/g' /etc/hosts.tmp
cat /etc/hosts.tmp > /etc/hosts
