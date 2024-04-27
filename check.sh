#!/bin/bash
file_path=""$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )""
if [ ! -f ionet_device_cache.json ]; then
    echo "Error: File to run the io.net worker not found."
    echo "Go to site https://cloud.io.net/worker/devices and run worker"
    echo "Guide to launching a worker https://medium.com/@bitcoin_50400/reload-worker-io-net-v2-01-c64f5def15a1"
    exit 1
fi
device_name=$(grep -o '"device_name":"[^"]*' $file_path/ionet_device_cache.json | cut -d'"' -f4)
device_id=$(grep -o '"device_id":"[^"]*' $file_path/ionet_device_cache.json | cut -d'"' -f4)
user_id=$(grep -o '"user_id":"[^"]*' $file_path/ionet_device_cache.json | cut -d'"' -f4)
operating_system=$(grep -o '"operating_system":"[^"]*' $file_path/ionet_device_cache.json | cut -d'"' -f4)
usegpus=$(grep -o '"usegpus":"[^"]*' $file_path/ionet_device_cache.json | cut -d'"' -f4)
arch=$(grep -o '"arch":"[^"]*' $file_path/ionet_device_cache.json | cut -d'"' -f4)
token=$(grep -o '"token":"[^"]*' $file_path/ionet_device_cache.json | cut -d'"' -f4)
echo "Device Name: $device_name"
echo "Operating System: $operating_system"
echo "Device ID: $device_id"
echo "User ID: $user_id"
launch_string="./io_net_launch_binary_linux --device_id="$device_id" --user_id="$user_id" --operating_system="$operating_system" --usegpus="$usegpus" --device_name="$device_name" --token="$token""
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
echo "Binary Name: $binary_name"
#colima start
token=$(awk -F'"' '{print $36}' ionet_device_cache.json)
MonID=$(docker ps -a | grep "io-worker-monitor" | awk '{print $1}')
MonCPU=$(docker stats --no-stream $MonID --format "{{.CPUPerc}}" | tr -d '%')
restart=false

while getopts ":r" opt; do
  case $opt in
    r)
      restart=true
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      ;;
  esac
done

if [[ $restart == true ]]; then
    action="RESTART"
fi

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
    rm -rf $file_path/$binary_name
    curl -L https://github.com/ionet-official/io_launch_binaries/raw/main/$binary_name -o $file_path/$binary_name
    chmod +x $file_path/$binary_name
    echo "START NEW NODE"
    echo "Yes" | $file_path/$launch_string --token "$token"
fi
