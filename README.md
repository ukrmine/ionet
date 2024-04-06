![Image alt](https://github.com/ukrmine/ionet/blob/main/pics/mAa0QmH3Nl9IyKqDAZzvuFNZhE0.webp)

# Script to monitor and restart the IO.NET worker
based on Linux Ubuntu 20.04 or Mac OS

Install CPU node for io.net. Tested: Digital Ocean Droplets with premium CPU and Azure D4as_v5 and Google cloud N1


You must be a root user (the line in the console must start with root). Change to root user "sudo -s"

![Image alt](https://github.com/ukrmine/ionet/blob/main/pics/1root.png)

Go to root folder, or another
<!--sec data-title="OS X и Linux" data-id="OSX_Linux_whoami" data-collapse=true ces-->
```
cd /root/
```
<!--endsec-->

Create a script, insert your Run Docker Command, take it from the site https://cloud.io.net/worker/devices
<!--sec data-title="OS X и Linux" data-id="OSX_Linux_whoami" data-collapse=true ces-->
```
cat > /root/check.sh <<EOF 
#!/bin/bash
launch_string="Yours Run Docker Command from https://cloud.io.net/"
file_path="/root"
binary_name=$(basename "${launch_string%% *}")
if docker ps -a --format '{{.Image}}' | grep -q "io-launch"; then
    echo "io-launch is WORKING, wait 5min"
    sleep 300
    if docker ps -a --format '{{.Image}}' | grep -q "io-launch"; then
        echo "io-launch still WORKING, STOP ALL CONTAINERS"
        docker rm -f $(docker ps -aq) 
    fi
fi
if [[ $(docker ps | grep -c "io-worker-monitor") -eq 1 && $(docker ps | grep -c "io-worker-vc") -eq 1 ]]; then
    echo "NODE IS WORKING"
else
    echo "STOP AND DELETE ALL CONTAINERS"
    docker rm -f $(docker ps -aq) && docker rmi -f $(docker images -q) 
    yes | docker system prune -a
    echo "DOWNLOAD FILES FOR Linux"
    rm -rf $binary_name && rm -rf ionet_device_cache.txt
    curl -L https://github.com/ionet-official/io_launch_binaries/raw/main/$binary_name -o $binary_name
    chmod +x $binary_name
    echo "START NEW NODE"
    cd "$file_path" && $launch_string
fi
EOF
```
<!--endsec-->
Take Run Docker Command, from the worker page (2. Copy and run the command below)

![Image alt](https://github.com/ukrmine/ionet/blob/main/pics/Copy_and_run_the_command.png)

Grant rights to run the script

<!--sec data-title="OS X и Linux" data-id="OSX_Linux_whoami" data-collapse=true ces-->
```
chmod +x check.sh
```
<!--endsec-->

Check how the script works﻿

<!--sec data-title="OS X и Linux" data-id="OSX_Linux_whoami" data-collapse=true ces-->
```
./check.sh
```
<!--endsec-->

If the containers are running, we will get it:

![Image alt](https://github.com/ukrmine/ionet/blob/main/pics/5check.png)

If at least one container is not running, we will get it:

![Image alt](https://github.com/ukrmine/ionet/blob/main/pics/6run_new_node.png)

Let's set up an autorun script

<!--sec data-title="OS X и Linux" data-id="OSX_Linux_whoami" data-collapse=true ces-->
```
crontab<<EOF
HOME=/root/
*/5 * * * * check.sh
EOF
```
<!--endsec-->

The script will check every 5 minutes to see if the worker is running and launch it if it is not.
To test the script, restart the server with the reboot command and wait for the worker to start without your participation.

Скрипт кожні 5 хвилин буде перевіряти чи працює воркер, і запускатиме якщо він не запущений.
Для того щоб перевірити роботу скрипта, перезапустіть сервер командою reboot і дочекайтесь щоб воркер запустився без Вашої участі.






