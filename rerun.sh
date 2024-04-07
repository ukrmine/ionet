#!/bin/bash
launch_string="Yours Run Docker Command"
file_path="/root"
binary_name=$(basename "${launch_string%% *}")
echo "STOP AND DELETE ALL CONTAINERS"
docker rm -f $(docker ps -aq) && docker rmi -f $(docker images -q) 
yes | docker system prune -a
echo "DOWNLOAD FILE $binary_name"
rm -rf $file_path/$binary_name && rm -rf $file_path/ionet_device_cache.txt
curl -L https://github.com/ionet-official/io_launch_binaries/raw/main/$binary_name -o $file_path/$binary_name
chmod +x $file_path/$binary_name
echo "START NEW NODE"
cd "$file_path" && $launch_string
