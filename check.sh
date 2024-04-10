#!/bin/bash
launch_string="Yours Run Docker Command"
file_path="/root"
binary_name=$(basename "${launch_string%% *}")
MonID=$(docker ps -a | grep "io-worker-monitor" | awk '{print $1}')
MonCPU=$(docker stats --no-stream $MonID --format "{{.CPUPerc}}" | tr -d '%')

if docker ps -a --format '{{.Image}}' | grep -q "io-launch"; then
    echo "io-launch is WORKING, wait 5min"
    sleep 300
    if docker ps -a --format '{{.Image}}' | grep -q "io-launch"; then
        echo "io-launch still WORKING, STOP ALL CONTAINERS"
        action="RESTART"
    fi
fi

if [[ $(docker ps | grep -c "io-worker-monitor") -eq 1 && $(docker ps | grep -c "io-worker-vc") -eq 1 ]]; then
    if [[ $(echo "$MonCPU >= 0.0" | bc -l) -eq 1 ]]; then
        echo "Containers is OK"
        echo "Monitor CPU usage $MonCPU%"
    else
	echo "Monitor not use CPU $MonCPU%"
	action="RESTART"
    fi
else
    echo "Containers are broken"
    action="RESTART"
fi

if [[ "$action" == "RESTART" ]]; then
    echo "STOP AND DELETE ALL CONTAINERS"
    docker rm -f $(docker ps -aq) && docker rmi -f $(docker images -q)
    yes | docker system prune -a
    echo "DOWNLOAD FILE $binary_name"
    rm -rf $file_path/$binary_name && rm -rf $file_path/ionet_device_cache.txt
    curl -L https://github.com/ionet-official/io_launch_binaries/raw/main/$binary_name -o $file_path/$binary_name
    chmod +x $file_path/$binary_name
    echo "START NEW NODE"
    cd "$file_path" && $launch_string
fi
