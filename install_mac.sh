#!/bin/bash
macos_ver=$(sw_vers -productVersion)
if [[ "$macos_ver" > "14.0" ]]; then
    echo "Your system is Sonoma $macos_ver"
else
    echo "It is recommended to update your Mac to the latest version of Sonoma"
fi
home_dir="$HOME/Documents/ionet"
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
#curl -L -o $home_dir/Docker.dmg https://desktop.docker.com/mac/main/arm64/145265/Docker.dmg
#sudo hdiutil attach Docker.dmg
#sudo /Volumes/Docker/Docker.app/Contents/MacOS/install --accept-license
#sudo hdiutil detach /Volumes/Docker
curl -L -o $home_dir/check.sh https://github.com/ukrmine/ionet/raw/main/check.sh
chmod +x $home_dir/check.sh
read -p "Yours Run Docker Command: " new_string
sed -i '' "s|launch_string=\"Yours Run Docker Command\"|launch_string=\"$new_string\"|" $home_dir/check.sh
sed -i '' "s|file_path=\"/root\"|file_path=\"$home_dir\"|" $home_dir/check.sh
crontab<<EOF
*/10 * * * * $home_dir/check.sh
EOF
rm $home_dir/install_mac.sh
rm $home_dir/Docker.dmg
softwareupdate --install-rosetta --agree-to-license
$home_dir/check.sh
