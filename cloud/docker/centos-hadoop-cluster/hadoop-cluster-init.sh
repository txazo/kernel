#!/bin/bash

hostname=`hostname`

if [ $hostname == 'master' ]; then
    cd /usr/local/hadoop
    echo -e "slave1\nslave2" > etc/slaves
    bin/hdfs namenode -format hadoop-cluster
fi

cp /etc/hosts /etc/hosts.tmp
sed -i 's/172\.24\..*/172\.24\.1\.11 master\n172\.24\.1\.12 slave1\n172\.24\.1\.13 slave2/g' /etc/hosts.tmp
cat /etc/hosts.tmp > /etc/hosts
