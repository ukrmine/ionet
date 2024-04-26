#!/bin/bash
home_dir="$HOME/Documents/ionet"
curl -L -o $home_dir/check.sh https://github.com/ukrmine/ionet/raw/main/check.sh
chmod +x $home_dir/check.sh
read -p "Yours Run Docker Command: " new_string
sed -i '' "s|launch_string=\"Yours Run Docker Command\"|launch_string=\"$new_string\"|" $home_dir/check.sh
sed -i '' "s|file_path=\"/root\"|file_path=\"$home_dir\"|" $home_dir/check.sh
sed -i '' "s|#colima start|colima start|" $home_dir/check.sh
crontab<<EOF
*/10 * * * * $home_dir/check.sh
EOF
rm $home_dir/check_mac.sh
softwareupdate --install-rosetta --agree-to-license
$home_dir/check.sh
