#!/bin/bash

conf="hadoop-cluster.conf"

function getProperty() {
    key=$1
    echo `cat $conf | awk -F ': ' '{
        if ($1 == "'${key}'") {
            print $2
        }
    }'`
}
