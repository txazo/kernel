#!/bin/bash

hdfs namenode -format

cd /usr/local/hadoop && sbin/start-all.sh
