#!/bin/bash
processor_type=$(sysctl -n machdep.cpu.brand_string)
if [[ "$processor_type" == *"Apple"* ]]; then
    echo "Your CPU is $processor_type"
else
    echo "Warning: This script is intended for Apple CPU only."
    exit 1
fi
macos_ver=$(sw_vers -productVersion)
if [[ "$macos_ver" > "14.0" ]]; then
    echo "Your system is Sonoma $macos_ver"
else
    echo "It is recommended to update your Mac to the latest version of Sonoma"
fi
home_dir="$HOME/Documents/ionet"
if [ ! -d "$home_dir" ]; then
    mkdir -p "$home_dir"
    echo "The folder $home_dir is created."
else
    echo "The folder $home_dir already exists."
fi
cd $home_dir
if ! command -v docker &> /dev/null; then
    echo "Docker is not installed. Install it via Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
    brew install --cask docker
    brew install docker docker-compose colima
    colima start
    unset DOCKER_HOST
    unset DOCKER_CERT_PATH
    unset DOCKER_TLS_VERIFY
    echo "Docker is successfully installed."
else
    echo "Docker is already installed."
fi
cache_file="ionet_device_cache"
new_string=""
if [ -f "$cache_file.json" ]; then
    echo "The file $cache_file.json exists."
    json_data=$(cat ionet_device_cache.json)
    arch=$(echo "$json_data" | awk -F', ' '{print $6}' | awk -F': ' '{print $2}' | tr -d '"')
    token=$(echo "$json_data" | awk -F', ' '{print $7}' | awk -F': ' '{print $2}' | tr -d '"')
else
    if [ -f "$cache_file.txt" ]; then
        echo "Old worker data found."
        json_data=$(cat ionet_device_cache.txt)
    else
        echo "No worker data found. Install a new worker."
        echo "Guide to launching a worker https://link.medium.com/vnbuHZ3kaJb - 1.3 command from this article"
        read -p "Run the command to connect device (worker) from https://cloud.io.net/worker/devices/" new_string
        exit 1
    fi
fi

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

if [ -z "$new_string" ]; then
    launch_string="./$binary_name --device_id="$device_id" --user_id="$user_id" --operating_system="$operating_system" --usegpus="$usegpus" --device_name="$device_name"" 
else
    launch_string="$new_string"
fi

curl -L https://github.com/ionet-official/io_launch_binaries/raw/main/$binary_name -o $home_dir/$binary_name
chmod +x $home_dir/$binary_name
curl -L -o $home_dir/check.sh https://github.com/ukrmine/ionet/raw/main/check.sh && chmod +x $home_dir/check.sh
sed -i '' "s|^file_path=.*|file_path=\"$home_dir\"|g" $home_dir/check.sh
sed -i '' "s|#colima start|colima start|" $home_dir/check.sh
#crontab<<EOF
#*/12 * * * * $home_dir/check.sh
#EOF
#rm $home_dir/install_mac.sh
#softwareupdate --install-rosetta --agree-to-license
#read -p "Run the command to connect device (worker) from https://cloud.io.net/worker/devices/" new_string
#$new_string
#echo "Yes" | $launch_string
#read -p "Paste your token for silent authentification" token
output=$(echo "Yes" | $home_dir/$launch_string | tee /dev/tty | grep "Option")
token=$(echo "$output" | grep "Use the following token as" | awk '{print $NF}')
echo "$token"
echo "Yes" | "$home_dir/$launch_string --token="$token""
echo "Wait until the containers are loaded for 10min."
sleep 420
$home_dir/check.sh
echo "Congratulation. Your IO worker is launched and ready."
