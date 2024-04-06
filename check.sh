#!/bin/bash
launch_string="Yours Run Docker Command from https://cloud.io.net/"
file_path="/root"
binary_name=$(basename "${launch_string%% *}")
if docker ps -a --format '{{.Image}}' | grep -q "io-launch"; then
    echo "io-launch is WORKING, wait 5min"
    sleep 300
    if docker ps -a --format '{{.Image}}' | grep -q "io-launch"; then
        echo "io-launch still WORKING, STOP ALL CONTAINERS"
        docker rm -f $(docker ps -aq) 
    fi
fi
if [[ $(docker ps | grep -c "io-worker-monitor") -eq 1 && $(docker ps | grep -c "io-worker-vc") -eq 1 ]]; then
    echo "NODE IS WORKING"
else
    echo "STOP AND DELETE ALL CONTAINERS"
    docker rm -f $(docker ps -aq) && docker rmi -f $(docker images -q) 
    yes | docker system prune -a
    echo "DOWNLOAD FILES FOR Linux"
    rm -rf $binary_name && rm -rf ionet_device_cache.txt
    curl -L https://github.com/ionet-official/io_launch_binaries/raw/main/$binary_name -o $binary_name
    chmod +x $binary_name
    echo "START NEW NODE"
    cd "$file_path" && $launch_string
fi
