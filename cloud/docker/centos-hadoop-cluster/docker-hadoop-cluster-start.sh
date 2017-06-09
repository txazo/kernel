#!/bin/bash

source ./docker-util.sh
source ./hadoop-cluster-env.sh

# 初始化network
echo "Init Network: ${networkName}"
docker network ls | awk 'NR > 1 {
    if ($2 == "'${networkName}'") {
        exists = 1;
    }
} END {
    if (!exists) {
        print 1;
    }
}' | while read line; do
    docker network create --subnet=${networkSubnet} ${networkName} >/dev/null 2>&1
done

cleanContainer

# 启动hadoop集群
for ((i=0; i < ${#nodeHost[*]}; i++))
do
    cmd="docker run --name ${nodeHost[$i]} -h ${nodeHost[$i]} --network ${networkName} --ip ${nodeIP[$i]} -d -P -p ${nodeSSHPort[$i]}:22"
    if [ "${nodeHost[$i]}" = "master" ]; then
        masterPort=`echo ${masterExposePort[*]} | awk -F " " '{for (i = 1; i <= NF; i++) print (i == 1 ? "-p " : " -p ")$i":"$i}'`
        eval $cmd $masterPort ${imageName} ">/dev/null 2>&1"
    else
        eval $cmd ${imageName} ">/dev/null 2>&1"
    fi
    echo "Hadoop Cluster Node [${nodeHost[$i]}]: started"
done

rm -f authorized_keys
for ((i=0; i < ${#nodeHost[*]}; i++))
do
    echo "Hadoop Cluster Node [${nodeHost[$i]}]: init"
    scp -P ${nodeSSHPort[$i]} hadoop-cluster-init.sh hadoop-cluster-env.sh root@${containerIP}:/root >/dev/null 2>&1
    echo `ssh root@${containerIP} -p ${nodeSSHPort[$i]} 'chmod u+x hadoop-cluster-init.sh; ./hadoop-cluster-init.sh'` >> authorized_keys
done

for ((i=0; i < ${#nodeHost[*]}; i++))
do
    echo "Hadoop Cluster Node [${nodeHost[$i]}]: add authorized_keys"
    scp -P ${nodeSSHPort[$i]} authorized_keys root@${containerIP}:/root >/dev/null 2>&1
    ssh root@${containerIP} -p ${nodeSSHPort[$i]} 'cat authorized_keys >> /root/.ssh/authorized_keys' >/dev/null 2>&1
done

echo "Hadoop Cluster start successed"
