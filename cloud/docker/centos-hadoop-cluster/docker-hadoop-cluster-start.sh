#!/bin/bash

imageName="centos-hadoop-cluster"
network="hadoop-cluster"
networkip="172.24.0.0/16"
ipPrefix="172.24.1."
masterIPMappings=(8088 9000 10020 19888 50070 50090)

# 初始化network
docker network ls | awk '{
    if (NR > 1 && $2 == "'${network}'") {
        exists = 1;
    }
} END {
    if (!exists) {
        print 1;
    }
}' | while read line; do
    docker network create --subnet=$networkip $network
done

echo ${masterIPMappings[*]} | awk 'BEGIN {FS=" "; ORS=""} {for (i = 1; i <= NF; i++) print (NF == 1 ? "" : " ")$i":"$i}'

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
