#!/bin/bash

# master
cd /usr/local/hadoop
sbin/start-dfs.sh
sbin/start-yarn.sh
sbin/mr-jobhistory-daemon.sh --config etc/hadoop start historyserver
