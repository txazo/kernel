#!/bin/bash

source ./docker-util.sh
source ./hadoop-cluster-conf.sh

image=`getProperty 'image'`
network=`getProperty 'network'`
networkIP=`getProperty 'networkip'`
ipPrefix=`getProperty 'ipPrefix'`
masterPortMappings=`getProperty 'masterPortMappings'`

# 初始化network
docker network ls | awk 'NR > 1 {
    if ($2 == "'${network}'") {
        exists = 1;
    }
} END {
    if (!exists) {
        print 1;
    }
}' | while read line; do
    docker network create --subnet=$networkIP $network
done

masterPort=`echo $masterPortMappings | awk 'BEGIN {FS=" "; ORS=""} {for (i = 1; i <= NF; i++) print (i == 1 ? "-p " : " -p ")$i":"$i}'`

cleanContainer

# 启动hadoop集群
ipNumber=10
sshPortPrefix=100
echo "" > host.tmp
echo `getProperty 'clusterNodes'` | awk -F " " '{for (i = 1; i <= NF; i++) print $i}' | while read hostname; do
    ip="${ipPrefix}${ipNumber}"
    port="${sshPortPrefix}22"
    cmd="docker run --name ${hostname} -h ${hostname} --network ${network} --ip ${ip} -d -P -p ${port}:22"
    if [ $hostname = 'master' ]; then
        eval $cmd $masterPort $image
    else
        eval $cmd $image
    fi
    echo "${ip} ${hostname}" >> host.tmp
    let ipNumber++
    let sshPortPrefix++
done

ipNumber=10
sshPortPrefix=100
echo `getProperty 'clusterNodes'` | awk -F " " '{for (i = 1; i <= NF; i++) print $i}' | while read hostname; do
    ip="${ipPrefix}${ipNumber}"
    port="${sshPortPrefix}"22

    echo "1-----${ip}-----${port}"
    scp -P $port hadoop-cluster-init.sh hadoop-cluster.conf hadoop-cluster-conf.sh host.tmp root@192.168.99.100:/root
    echo "2-----${ip}-----${port}"
    id_ras_pub=`ssh root@$192.168.99.100 -p $port 'chmod u+x hadoop-cluster-init.sh hadoop-cluster-conf.sh; ./hadoop-cluster-init.sh'`
    echo $id_ras_pub
    let ipNumber++
    let sshPortPrefix++
done
