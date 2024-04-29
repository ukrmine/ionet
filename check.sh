#!/bin/bash
file_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

if [ -f "ionet_device_cache.json" ]; then
    echo "Configuration file found."
    device_file="ionet_device_cache.json"
else
    echo "Configuration file not found."
    exit 1
fi

device_name=$(grep -o '"device_name":"[^"]*' $file_path/$device_file | cut -d'"' -f4)
device_id=$(grep -o '"device_id":"[^"]*' $file_path/$device_file | cut -d'"' -f4)
user_id=$(grep -o '"user_id":"[^"]*' $file_path/$device_file | cut -d'"' -f4)
operating_system=$(grep -o '"operating_system":"[^"]*' $file_path/$device_file | cut -d'"' -f4)
usegpus=$(grep -o '"usegpus":"[^"]*' $file_path/$device_file | cut -d'"' -f4)
arch=$(grep -o '"arch":"[^"]*' $file_path/$device_file | cut -d'"' -f4)
token=$(grep -o '"token":"[^"]*' $file_path/$device_file | cut -d'"' -f4)
echo "Device Name: $device_name"
echo "Device ID: $device_id"
echo "User ID: $user_id"

case $operating_system in
    "macOS")
        binary_name="io_net_launch_binary_mac"
        ;;
    "Linux")
        binary_name="io_net_launch_binary_linux"
        ;;
    "Windows")
        binary_name="io_net_launch_binary_windows.exe"
        ;;
    *)
        echo "Unsupported operating system: $operating_system"
        exit 1
        ;;
esac
#colima start
token=$(awk -F'"' '{print $36}' $device_file)
MonID=$(docker ps -a | grep "io-worker-monitor" | awk '{print $1}')
MonCPU=$(docker stats --no-stream $MonID --format "{{.CPUPerc}}" | tr -d '%')
launch_string="./io_net_launch_binary_linux --device_id="$device_id" --user_id="$user_id" --operating_system="$operating_system" --usegpus="$usegpus" --device_name="$device_name" --token="$token""

if [[ "$1" == "-r" ]]; then
    action="RESTART"
else
    if docker ps -a --format '{{.Image}}' | grep -q "io-launch"; then
        echo "io-launch container is WORKING, wait 5min"
        sleep 300
        if docker ps -a --format '{{.Image}}' | grep -q "io-launch"; then
            echo "io-launch container still WORKING, STOP ALL CONTAINERS"
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
fi

if [[ "$action" == "RESTART" ]]; then
    echo "STOP AND DELETE ALL CONTAINERS"
    docker rm -f $(docker ps -aq) && docker rmi -f $(docker images -q)
    yes | docker system prune -a
    echo "DOWNLOAD FILE $binary_name"
    rm -rf $file_path/$binary_name
    curl -L https://github.com/ionet-official/io_launch_binaries/raw/main/$binary_name -o $file_path/$binary_name
    chmod +x $file_path/$binary_name
    echo "START NEW NODE"
    echo "Yes" | $file_path/$launch_string
fi
