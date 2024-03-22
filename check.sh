#!/bin/bash

YOURDEVICEID=
YOURUSERID=
YOURDEVICENAME=

if docker ps | grep -q "io-worker-monitor" && docker ps | grep -q "io-worker-vc"; then
    echo "NODE IS WORKING"
else
 echo "NODE ERROR, STOP AND DELETE ALL CONTAINERS"
 docker rm -f $(docker ps -aq) && docker rmi -f $(docker images -q) 
 yes | docker system prune -a
 #echo "DOWNLOAD FILES FOR MAC"
 #rm -rf launch_binary_mac && rm -rf ionet_device_cache.txt
 #curl -L https://github.com/ionet-official/io_launch_binaries/raw/main/launch_binary_mac -o launch_binary_mac
 #chmod +x launch_binary_mac
 echo "DOWNLOAD FILES FOR LINUX"
 rm -rf launch_binary_linux && rm -rf ionet_device_cache.txt
 curl -L https://github.com/ionet-official/io_launch_binaries/raw/main/launch_binary_linux -o launch_binary_linux
 chmod +x launch_binary_linux
 echo "START NEW NODE"
 /root/launch_binary_linux --device_id=$YOURDEVICEID --user_id=$YOURUSERID --operating_system="Linux" --usegpus=false --device_name=$YOURDEVICENAME
fi
