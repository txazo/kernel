#!/bin/bash
#
# Usage: Hive Web Interface build

hiveVersion="1.2.2"
HIVE_HOME=/usr/local/hive

wget https://mirrors.tuna.tsinghua.edu.cn/apache/hive/hive-1.2.2/apache-hive-1.2.2-src.tar.gz

tar -zxvf apache-hive-${hiveVersion}-src.tar.gz
jar cfM hive-hwi-${hiveVersion}.war -C apache-hive-${hiveVersion}-src/hwi/web .
mv hive-hwi-${hiveVersion}.war $HIVE_HOME/lib

rm -rf apache-hive-${hiveVersion}-src*
