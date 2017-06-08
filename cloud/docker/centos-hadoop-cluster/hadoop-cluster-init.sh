#!/bin/bash
#
# Usage: Init Hadoop Cluster

source ./hadoop-cluster-env.sh

hostname=`hostname`

# 初始化master节点etc/hadoop/slaves
if [ $hostname = 'master' ]; then
    cd /usr/local/hadoop
    echo ${nodeHost[*]} | awk -F " " '{for (i = 1; i <= NF; i++) {if ($i != "master") {print $i}}}' > etc/hadoop/slaves
fi

# 初始化节点/etc/hosts
for ((i=0; i < ${#nodeHost[*]}; i++))
do
    if [ "${nodeHost[$i]}" != "${hostname}" ]; then
        echo -e "${nodeIP[$i]} \t${nodeHost[$i]}" >> /etc/hosts
    fi
done

# 初始化ssh
ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa >/dev/null 2>&1
echo `cat ~/.ssh/id_rsa.pub`
