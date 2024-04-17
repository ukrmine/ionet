![Image alt](https://github.com/ukrmine/ionet/blob/main/pics/mAa0QmH3Nl9IyKqDAZzvuFNZhE0.webp)

# Scripts for IO.NET worker install
## based on Linux Ubuntu 20.04 or Mac OS

Install CPU node for io.net. 
Tested: Digital Ocean Droplets AMD Premium, Azure D4as_v5, D2s_v5, Google cloud N1, OVHcloud B3-16, Kamatera

## Preparation on site https://cloud.io.net/worker/devices/

Create new worker

![Image alt](https://github.com/ukrmine/ionet/blob/main/pics/Create_new_worker.png)

Configure new worker

![Image alt](https://github.com/ukrmine/ionet/blob/main/pics/Configure_worker.png)

## Install worker on Linux server

1. Change user to root

<!--sec data-title="OS X и Linux" data-id="OSX_Linux_whoami" data-collapse=true ces-->
```
sudo -s
```
<!--endsec-->

2. Download script and execute script to create VM for ionet worker depolyment

<!--sec data-title="OS X и Linux" data-id="OSX_Linux_whoami" data-collapse=true ces-->
```
cd /home && curl -L https://github.com/ukrmine/ionet/raw/main/install.sh -o install.sh && chmod +x install.sh && ./install.sh
```
<!--endsec-->

Please choose Hosting or CPU type, put your Docker Command, VM Hostname

![Image alt](https://github.com/ukrmine/ionet/blob/main/pics/install.png)
    
Wait about 10 min.
All is done, worker was installed and configured

## Stopping and Remove Docker containers, Uninstall Docker and NVIDIA
<!--sec data-title="OS X и Linux" data-id="OSX_Linux_whoami" data-collapse=true ces-->
```
curl -L https://github.com/ukrmine/ionet/raw/main/reset_drivers_and_docker.sh -o reset_drivers_and_docker.sh && chmod +x reset_drivers_and_docker.sh && ./reset_drivers_and_docker.sh

```
<!--endsec-->

