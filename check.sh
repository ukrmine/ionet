#!/bin/bash
file_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
#colima start

check_file() {
if [ -f "$file_path/ionet_device_cache.json" ]; then
    json_data=$(cat $file_path/ionet_device_cache.json)
    token=$(echo "$json_data" | awk -F',' '{print $9}' | awk -F':' '{print $2}' | tr -d '"')
    if [[ -n $token ]]; then
        echo "Worker data found with token. Run worker"
        check_io_launch
        check_containers
    else
        echo "Worker data found without token. Add web token"
        exit 1
    fi
else
    echo "Configuration file not found. Install worker"
    exit 1
fi
}

get_data() {
device_name=$(echo "$json_data" | awk -F',' '{print $1}' | awk -F':' '{print $2}' | tr -d '"')
device_id=$(echo "$json_data" | awk -F',' '{print $2}' | awk -F':' '{print $2}' | tr -d '"')
user_id=$(echo "$json_data" | awk -F',' '{print $3}' | awk -F':' '{print $2}' | tr -d '"')
operating_system=$(echo "$json_data" | awk -F',' '{print $4}' | awk -F':' '{print $2}' | tr -d '"')
usegpus=$(echo "$json_data" | awk -F',' '{print $5}' | awk -F':' '{print $2}' | tr -d '"}')
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

launch_string="./$binary_name --device_id="$device_id" --user_id="$user_id" --operating_system="$operating_system" --usegpus="$usegpus" --device_name="$device_name""
}

check_io_launch() {
if docker ps -a --format '{{.Image}}' | grep -q "io-launch"; then
    echo "io-launch container is WORKING, wait 5min"
    sleep 300
    if docker ps -a --format '{{.Image}}' | grep -q "io-launch"; then
        echo "io-launch container still WORKING, STOP ALL CONTAINERS"
        get_data
        restart
    fi
fi
}

check_containers() {
if [[ $(docker ps | grep -c "io-worker-monitor") -eq 1 && $(docker ps | grep -c "io-worker-vc") -eq 1 ]]; then
    MonID=$(docker ps -a | grep "io-worker-monitor" | awk '{print $1}')
    MonCPU=$(docker stats --no-stream $MonID --format "{{.CPUPerc}}" | tr -d '%')
    if [[ $(echo "$MonCPU >= 0.0" | bc -l) -eq 1 ]]; then
        echo "Containers is OK"
        echo "Monitor CPU usage $MonCPU%"
        exit 1
    else
        echo "Monitor not use CPU $MonCPU%"
        get_data
        restart
    fi
else
    echo "Containers are broken"
    get_data
    restart
fi
}

restart() {
echo "STOP AND DELETE ALL CONTAINERS"
docker rm -f $(docker ps -aq) && docker rmi -f $(docker images -q)
yes | docker system prune -a
echo "DOWNLOAD FILE $binary_name"
rm -rf $file_path/$binary_name
curl -L https://github.com/ionet-official/io_launch_binaries/raw/main/$binary_name -o $file_path/$binary_name
chmod +x $file_path/$binary_name
echo "START NEW NODE"
echo "Yes" | $file_path/$launch_string
}

if [[ "$1" == "-r" ]]; then
    get_data
    restart
fi

check_file

