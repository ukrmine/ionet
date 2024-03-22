![Image alt](https://github.com/ukrmine/ionet/blob/main/pics/mAa0QmH3Nl9IyKqDAZzvuFNZhE0.webp)

# Script to monitor and restart the IO.NET worker
based on Linux Ubuntu 20.04 or Mac OS

Can install CPU node for io.net. Tested: Digital Ocean Droplets with premium CPU and Azure D4as_v5


You must be a root user (the line in the console must start with root)

![Image alt](https://github.com/ukrmine/ionet/blob/main/pics/1root.png)

Go to root folder
<!--sec data-title="OS X и Linux" data-id="OSX_Linux_whoami" data-collapse=true ces-->
```
cd /root/
```
<!--endsec-->

Create a script file
<!--sec data-title="OS X и Linux" data-id="OSX_Linux_whoami" data-collapse=true ces-->
```
cat > /root/check.sh <<EOF 
#!/bin/bash 
if docker ps | grep -q "io-worker-monitor" && docker ps | grep -q "io-worker-vc"; then
 echo "NODE IS WORKING." 
else 
 echo "NODE ERROR, STOP AND DELETE ALL CONTAINERS"
 docker rm -f $(docker ps -aq) && docker rmi -f $(docker images -q) 
 yes | docker system prune -a
 #echo "DOWNLOAD FILES FOR MAC"
 #rm -rf launch_binary_mac && rm -rf ionet_device_cache.txt
 #curl -L https://github.com/ionet-official/io_launch_binaries/raw/main/launch_binary_mac -o launch_binary_mac
 #chmod +x launch_binary_mac
 echo "DOWNLOAD FILES FOR LINUX"
 rm -rf launch_binary_linux && rm -rf ionet_device_cache.txt
 curl -L https://github.com/ionet-official/io_launch_binaries/raw/main/launch_binary_linux -o launch_binary_linux
 chmod +x launch_binary_linux
 echo "START NEW NODE"
 Here you need to paste a line from the site (2. Copy and run the command below)
fi 
EOF
```
<!--endsec-->
The line ./launch_binary_linux... needs to be replaced, take it from the office (2. Copy and run the command below)

![Image alt](https://github.com/ukrmine/ionet/blob/main/pics/Copy_and_run_the_command.png)

Grant rights to run the script

<!--sec data-title="OS X и Linux" data-id="OSX_Linux_whoami" data-collapse=true ces-->
```
chmod +x /root/check.sh
```
<!--endsec-->

Check how the script works﻿

<!--sec data-title="OS X и Linux" data-id="OSX_Linux_whoami" data-collapse=true ces-->
```
/root/check.sh
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
*/5 * * * * /root/check.sh
EOF
```
<!--endsec-->

The script will check every 5 minutes to see if the worker is running and launch it if it is not.
To test the script, restart the server with the reboot command and wait for the worker to start without your participation.

Скрипт кожні 5 хвилин буде перевіряти чи працює воркер, і запускатиме якщо він не запущений.
Для того щоб перевірити роботу скрипта, перезапустіть сервер командою reboot і дочекайтесь щоб воркер запустився без Вашої участі.






