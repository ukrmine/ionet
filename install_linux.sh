#!/bin/bash
home_dir="/root"
if [ ! -d "$home_dir" ]; then
    mkdir -p "$home_dir"
    echo "The folder $home_dir is created."
else
    echo "The folder $home_dir already exists."
fi

apt-get update && apt-get upgrade -y
cd $home_dir
curl -L -o $home_dir/ionet-setup.sh https://github.com/ionet-official/io-net-official-setup-script/raw/main/ionet-setup.sh
chmod +x $home_dir/ionet-setup.sh
$home_dir/ionet-setup.sh
curl -L -o $home_dir/check.sh https://github.com/ukrmine/ionet/raw/main/check.sh
chmod +x $home_dir/check.sh
sed -i '' "s|^file_path=.*|file_path=\"$home_dir\"|g" $home_dir/check.sh
sed -i '' "s|colima start|#colima start|" $home_dir/check.sh
cache_file="$home_dir/ionet_device_cache"
new_string=""

if ! command -v docker &> /dev/null; then
    echo "Docker is not installed."
    curl -fsSL https://get.docker.com/ -o $home_dir/get-docker.sh
    sh $home_dir/get-docker.sh
else
    echo "Docker is already installed."
fi

install_without_token() {
device_name=$(echo "$json_data" | awk -F', ' '{print $1}' | awk -F': ' '{print $2}' | tr -d '"')
device_id=$(echo "$json_data" | awk -F', ' '{print $2}' | awk -F': ' '{print $2}' | tr -d '"')
user_id=$(echo "$json_data" | awk -F', ' '{print $3}' | awk -F': ' '{print $2}' | tr -d '"')
operating_system=$(echo "$json_data" | awk -F', ' '{print $4}' | awk -F': ' '{print $2}' | tr -d '"')
usegpus=$(echo "$json_data" | awk -F', ' '{print $5}' | awk -F': ' '{print $2}' | tr -d '"}')
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
}

new_install() {
echo "Guide to launching a worker. Insert the command 1.3 from article https://link.medium.com/vnbuHZ3kaJb"
read -p "Run the command to connect device (worker) from https://cloud.io.net/worker/devices/ : " new_string
#echo "Device Name: $(echo "$new_string" | awk -F'[ =]' '{print $11}')"
#echo "Device ID: $(echo "$new_string" | awk -F'[ =]' '{print $3}')"
#echo "User ID: $(echo "$new_string" | awk -F'[ =]' '{print $5}')"
device_name=$(echo "$new_string" | awk -F'[ =]' '{print $11}')
device_id=$(echo "$new_string" | awk -F'[ =]' '{print $3}')
user_id=$(echo "$new_string" | awk -F'[ =]' '{print $5}')
operating_system=$(echo "$new_string" | awk -F'[ =]' '{print $7}')
usegpus=$(echo "$new_string" | awk -F'[ =]' '{print $9}')
binary_name=$(echo "$new_string" | sed 's|^\./||' | awk '{print $1}')
echo "Device Name: $device_name"
echo "Device ID: $device_id"
echo "User ID: $user_id"
}

autorun() {
crontab<<EOF
*/12 * * * * $home_dir/check.sh
EOF
}

#curl -L -o $home_dir/check.sh https://github.com/ukrmine/ionet/raw/main/check.sh
#chmod +x $home_dir/check.sh
#sed -i '' "s|^file_path=.*|file_path=\"$home_dir\"|g" $home_dir/check.sh
#sed -i '' "s|colima start|#colima start|" $home_dir/check.sh
##new_string=""

if [ -f "$cache_file.json" ]; then
    json_data=$(cat $cache_file.json)
    token=$(echo "$json_data" | awk -F',' '{print $9}' | awk -F':' '{print $2}' | tr -d '"')
    if [[ -n $token ]]; then
        echo "Worker data found with token. Run worker"
        $home_dir/check.sh
        exit 1
    else
        echo "Worker data found without token."
        json_data=$(cat $cache_file.json)
        install_without_token
    fi
else
    if [ -f "$cache_file.txt" ]; then
        echo "Old worker data found."
        json_data=$(cat $cache_file.txt)
        install_without_token
    else
        echo "No worker data found. Install a new worker."
        new_install
    fi
fi

echo "launch_string is $launch_string"
curl -L https://github.com/ionet-official/io_launch_binaries/raw/main/$binary_name -o $home_dir/$binary_name
chmod +x $home_dir/$binary_name

echo "binary_name is $binary_name"

if [[ -n $new_string ]]; then
    launch_string="$binary_name --device_id="$device_id" --user_id="$user_id" --operating_system="$operating_system" --usegpus="$usegpus" --device_name="$device_name""
else
    launch_string=${new_string#./}
fi
echo "123123123213213123123123"
output=$(echo "Yes" | $home_dir/$launch_string | tee /dev/tty)
token=$(echo "$output" | grep "Use the following token as" | awk '{print $NF}')
sed -i '' 's/\("token":\)""/\1"'$token'"/' ionet_device_cache.json
#echo "Wait until the containers are loaded for 10min."
#sleep 420
#$home_dir/check.sh
#autorun
#rm $home_dir/install_mac.sh
#echo "Congratulation. Your IO worker is launched and ready."
