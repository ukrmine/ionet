#!/bin/bash
macos_ver=$(sw_vers -productVersion)
if [[ "$macos_ver" > "14.0" ]]; then
    echo "Your system is Sonoma $macos_ver"
else
    echo "It is recommended to update your Mac to the latest version of Sonoma"
fi
home_dir="$HOME/Documents/ionet"
if [ ! -d "$home_dir" ]; then
    mkdir -p "$home_dir"
    echo "The folder /ionet is created."
else
    echo "The folder /ionet already exists."
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

device_name=$(awk -F'"' '/"device_id":/{print $4}' $file_path/$device_file)
device_id=$(awk -F'"' '/"device_id":/{print $4}' $file_path/$device_file)
user_id=$(awk -F'"' '/"device_id":/{print $4}' $file_path/$device_file)
operating_system=$(awk -F'"' '/"device_id":/{print $4}' $file_path/$device_file)
usegpus=$(awk -F'"' '/"device_id":/{print $4}' $file_path/$device_file)
arch=$(awk -F'"' '/"device_id":/{print $4}' $file_path/$device_file)
token=$(awk -F'"' '/"device_id":/{print $4}' $file_path/$device_file)
echo "Device Name: $device_name"
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

curl -L https://github.com/ionet-official/io_launch_binaries/raw/main/io_net_launch_binary_mac -o $home_dir/io_net_launch_binary_mac
chmod +x $home_dir/io_net_launch_binary_mac
curl -L -o $home_dir/check.sh https://github.com/ukrmine/ionet/raw/main/check.sh && chmod +x $home_dir/check.sh
sed -i '' "s|^file_path=.*|file_path=\"$home_dir\"|g" $home_dir/check.sh
sed -i '' "s|#colima start|colima start|" $home_dir/check.sh
crontab<<EOF
*/12 * * * * $home_dir/check.sh
EOF
rm $home_dir/install_mac.sh
softwareupdate --install-rosetta --agree-to-license
read -p "Run the command to connect device (worker) from https://cloud.io.net/worker/devices/" new_string
$new_string
echo "Insssssttttaaaaalllaaattttiiiooonnn Ended"
