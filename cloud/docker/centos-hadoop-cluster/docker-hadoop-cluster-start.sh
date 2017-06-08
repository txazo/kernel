#!/bin/bash

source ./hadoop-cluster-conf.sh

image=`getProperty 'image'`
network=`getProperty 'network'`
networkip=`getProperty 'networkip'`
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
    docker network create --subnet=$networkip $network
done

port=`echo $masterPortMappings | awk 'BEGIN {FS=" "; ORS=""} {for (i = 1; i <= NF; i++) print (i == 1 ? "" : " ")$i":"$i}'`

# 启动hadoop集群
ipNumber=10
sshPortPrefix=100
cat hadoop-cluster-host.conf | while read hostname; do
    docker run --name $hostname -h $hostname --network $network --ip "${ipPrefix}${ipNumber}" -d -P -p "${sshPortPrefix}"22:22 $imageName
    let ipNumber++
    let sshPortPrefix++
done

if ssh root@192.168.99.100 -p 10222 test -e /root/.ssh/id_rsa1; then
    scp -P 10222 docker-build-init.sh root@192.168.99.100:/root
    id_ras_pub=`ssh root@192.168.99.100 -p 10222 'chmod u+x docker-build-init.sh; ./docker-build-init.sh; rm -f docker-build-init.sh'`
fi
