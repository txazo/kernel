#!/bin/bash
#
# Usage: Init Hive MySQL

HIVE_HOME=/usr/local/hive
HADOOP_HOME=/usr/local/hadoop

hdfsStatus=`jps | awk '{print $2}' | grep '^NameNode$'`
if ! [ $hdfsStatus ];then
    echo "HDFS format"
    ${HADOOP_HOME}/bin/hdfs namenode -format -force >/dev/null 2>&1
    echo "HDFS start"
    ${HADOOP_HOME}/sbin/start-dfs.sh >/dev/null 2>&1
fi

echo "HDFS init"
${HADOOP_HOME}/bin/hdfs dfs -mkdir -p /user/hive/log >/dev/null 2>&1
${HADOOP_HOME}/bin/hdfs dfs -mkdir -p /user/hive/tmp >/dev/null 2>&1
${HADOOP_HOME}/bin/hdfs dfs -mkdir -p /user/hive/warehouse >/dev/null 2>&1
${HADOOP_HOME}/bin/hdfs dfs -chmod 777 /user/hive/log >/dev/null 2>&1
${HADOOP_HOME}/bin/hdfs dfs -chmod 777 /user/hive/tmp >/dev/null 2>&1
${HADOOP_HOME}/bin/hdfs dfs -chmod 777 /user/hive/warehouse >/dev/null 2>&1

echo "Copy Hive Configuration File"
cp conf/hive-env.sh ${HIVE_HOME}/conf
cp conf/hive-site.xml ${HIVE_HOME}/conf

echo "Copy MySQL Connector Driver"
mysqlVersion=`ls ~/.m2/repository/mysql/mysql-connector-java | awk -F " " '{print $1}' | sort -r | head -1`
cp ~/.m2/repository/mysql/mysql-connector-java/${mysqlVersion}/mysql-connector-java-${mysqlVersion}.jar ${HIVE_HOME}/lib

echo "MySQL init"
echo 'drop database hive_db' | mysql -uroot -proot -h127.0.0.1 >/dev/null 2>&1
echo 'create database hive_db' | mysql -uroot -proot -h127.0.0.1 >/dev/null 2>&1

echo "Hive schema init"
${HIVE_HOME}/bin/schematool -dbType mysql -initSchema >/dev/null 2>&1

echo "Hive init successed"
