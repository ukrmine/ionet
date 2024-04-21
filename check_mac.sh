#!/bin/bash
curl -L -o ~/Documents/ionet/check.sh https://github.com/ukrmine/ionet/raw/main/check.sh
chmod +x ~/Documents/ionet/check.sh
read -p "Yours Run Docker Command: " launch_string
sed -i '' "s|launch_string=\"Yours Run Docker Command\"|launch_string=\"$new_string\"|" ~/Documents/ionet/check.sh
crontab<<EOF
*/10 * * * * ~/Documents/ionet/check.sh
EOF
rm ~/Documents/ionet/check_mac.sh
