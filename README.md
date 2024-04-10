![Image alt](https://github.com/ukrmine/ionet/blob/main/pics/mAa0QmH3Nl9IyKqDAZzvuFNZhE0.webp)

# Scripts for IO.NET worker install
## based on Linux Ubuntu 20.04 or Mac OS

Install CPU node for io.net. 
Tested: Digital Ocean Droplets AMD Premium, Azure D4as_v5, D2s_v5, Google cloud N1, OVHcloud B3-16, Kamatera

1. Change user to root

<!--sec data-title="OS X и Linux" data-id="OSX_Linux_whoami" data-collapse=true ces-->
```
sudo -s
```
<!--endsec-->

2. Download script

<!--sec data-title="OS X и Linux" data-id="OSX_Linux_whoami" data-collapse=true ces-->
```
cd /home && curl -L https://github.com/ukrmine/ionet/raw/main/install.sh -o install.sh
```
<!--endsec-->

3. Execute script to create VM for ionet worker depolyment

<!--sec data-title="OS X и Linux" data-id="OSX_Linux_whoami" data-collapse=true ces-->
```
chmod +x install.sh && ./install.sh
```
<!--endsec-->

You can change (CPU type, Hostname, Login, Password, Home directory, Disk size, IP address), or leave default setings

![Image alt](https://github.com/ukrmine/ionet/blob/main/pics/install1.png)
    
4. Login to created VM put just command "noda" if you want to exit put "exit"

5. Than install yours worker on VM

To be continued !!!

# Scripts for IO.NET worker check containers and rebuild

You must be a root user (the line in the console must start with root). Change to root user "sudo -s"

![Image alt](https://github.com/ukrmine/ionet/blob/main/pics/1root.png)

1. Go to root folder and download script

<!--sec data-title="OS X и Linux" data-id="OSX_Linux_whoami" data-collapse=true ces-->
```
cd /root/ && curl -L https://github.com/ukrmine/ionet/raw/main/check.sh -o check.sh
```
<!--endsec-->

Take "Run Docker Command", take it from the worker page https://cloud.io.net/worker/devices (2. Copy and run the command below)

![Image alt](https://github.com/ukrmine/ionet/blob/main/pics/Copy_and_run_the_command.png)

2. Insert your "Run Docker Command" in to script

<!--sec data-title="OS X и Linux" data-id="OSX_Linux_whoami" data-collapse=true ces-->
```
nano /root/check.sh
```
<!--endsec-->

![Image alt](https://github.com/ukrmine/ionet/blob/main/pics/check.png)

Exit from nano ctrl+x ->  y -> Enter

3. Grant rights and run the script

<!--sec data-title="OS X и Linux" data-id="OSX_Linux_whoami" data-collapse=true ces-->
```
chmod +x /root/check.sh && /root/check.sh
```
<!--endsec-->

If the containers are running, we will get it:

![Image alt](https://github.com/ukrmine/ionet/blob/main/pics/5check.png)

If at least one container is not running, we will get it:

![Image alt](https://github.com/ukrmine/ionet/blob/main/pics/6run_new_node.png)

Set up the automatic execution of the script

<!--sec data-title="OS X и Linux" data-id="OSX_Linux_whoami" data-collapse=true ces-->
```
crontab<<EOF
HOME=/root/
*/10 * * * * check.sh
EOF
```
<!--endsec-->

The script will check every 5 minutes to see if the worker is running and launch it if it is not.
To test the script, restart the server with the reboot command and wait for the worker to start without your participation.

Скрипт кожні 5 хвилин буде перевіряти чи працює воркер, і запускатиме якщо він не запущений.
Для того щоб перевірити роботу скрипта, перезапустіть сервер командою reboot і дочекайтесь щоб воркер запустився без Вашої участі.






