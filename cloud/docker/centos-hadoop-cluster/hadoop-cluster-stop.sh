#!/bin/bash

# master
cd /usr/local/hadoop
sbin/stop-dfs.sh
sbin/stop-yarn.sh
sbin/mr-jobhistory-daemon.sh --config etc/hadoop stop historyserver
