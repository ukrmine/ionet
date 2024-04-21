#!/bin/bash
curl -L -o ~/Documents/ionet/check.sh https://github.com/ukrmine/ionet/raw/main/check.sh
chmod +x ~/Documents/ionet/check.sh
read -p "Yours Run Docker Command: " launch_string
sed -i 'sh' "2s/.*/launch_string=\"$launch_string\"/" ~/Documents/ionet/check.sh
crontab<<EOF
*/10 * * * * ~/Documents/ionet/check.sh
EOF
