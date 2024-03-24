#!/bin/bash 
system=linux #linux or mac
gpu=false #false or true
device_id=""
user_id=""
device_name=""
if [[ "$system" == "linux" ]]; then
    os="Linux"
elif [[ "$system" == "mac" ]]; then
    os="macOS"
echo "NODE ERROR, STOP AND DELETE ALL CONTAINERS"
docker rm -f $(docker ps -aq) && docker rmi -f $(docker images -q) 
yes | docker system prune -a
echo "DOWNLOAD FILES FOR LINUX"
rm -rf launch_binary_$system && rm -rf ionet_device_cache.txt
curl -L https://github.com/ionet-official/io_launch_binaries/raw/main/launch_binary_$system -o launch_binary_$system
chmod +x launch_binary_$system
echo "START NEW NODE"
/root/launch_binary_$system --device_id=$device_id --user_id=$user_id --operating_system="$os" --usegpus=$gpu --device_name=$device_name
