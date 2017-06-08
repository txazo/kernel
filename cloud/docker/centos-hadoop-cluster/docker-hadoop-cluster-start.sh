#!/bin/bash

source ./docker-util.sh
source ./hadoop-cluster-env.sh

# 初始化network
docker network ls | awk 'NR > 1 {
    if ($2 == "'${networkName}'") {
        exists = 1;
    }
} END {
    if (!exists) {
        print 1;
    }
}' | while read line; do
    docker network create --subnet=${networkSubnet} ${networkName}
done

masterPort=`echo ${masterExposePort[*]} | awk -F " " '{for (i = 1; i <= NF; i++) print (i == 1 ? "-p " : " -p ")$i":"$i}'`

cleanContainer

# 启动hadoop集群
for ((i=0; i < ${#nodeHost[*]}; i++))
do
    cmd="docker run --name ${nodeHost[$i]} -h ${nodeHost[$i]} --network ${networkName} --ip ${nodeIP[$i]} -d -P -p ${nodeSSHPort[$i]}:22"
    if [ "${nodeHost[$i]}" = "master" ]; then
        eval $cmd $masterPort ${imageName}
    else
        eval $cmd ${imageName}
    fi
done

rm -f authorized_keys
for ((i=0; i < ${#nodeHost[*]}; i++))
do
    scp -P ${nodeSSHPort[$i]} hadoop-cluster-init.sh hadoop-cluster-env.sh root@${containerIP}:/root
    echo `ssh root@${containerIP} -p ${nodeSSHPort[$i]} 'chmod u+x hadoop-cluster-init.sh; ./hadoop-cluster-init.sh'` >> authorized_keys
done

for ((i=0; i < ${#nodeHost[*]}; i++))
do
    scp -P ${nodeSSHPort[$i]} authorized_keys root@${containerIP}:/root
    echo `ssh root@${containerIP} -p ${nodeSSHPort[$i]} 'cat authorized_keys >> /root/.ssh/authorized_keys'`
done
