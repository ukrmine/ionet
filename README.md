![Image alt](https://github.com/ukrmine/ionet/blob/main/pics/mAa0QmH3Nl9IyKqDAZzvuFNZhE0.webp)

# Scripts for IO.NET worker install, which based on Linux Ubuntu 20.04 or Mac OS

## Preparation on site https://cloud.io.net/worker/devices/

1.1 Create new worker

![Image alt](https://github.com/ukrmine/ionet/blob/main/pics/Create_new_worker.png)

1.2 Configure new worker

![Image alt](https://github.com/ukrmine/ionet/blob/main/pics/Configure_worker.png)

## Install worker on Linux server

2.1 Change user to root

<!--sec data-title="OS X и Linux" data-id="OSX_Linux_whoami" data-collapse=true ces-->
```
sudo -s
```
<!--endsec-->

2.2 Download script and execute script to create VM for ionet worker depolyment

<!--sec data-title="OS X и Linux" data-id="OSX_Linux_whoami" data-collapse=true ces-->
```
cd /home && curl -L https://github.com/ukrmine/ionet/raw/main/install.sh -o install.sh && chmod +x install.sh && ./install.sh
```
<!--endsec-->

2.3 Please choose 
1. Hosting or CPU type 
2. Paste the line your Docker Command that you copied earlier in paragraph 1.2
3. Input VM name

![Image alt](https://github.com/ukrmine/ionet/blob/main/pics/install.png)
    
Wait about 10-20 min.
All is done, worker was installed and configured

## -- Stopping and Remove Docker containers, Uninstall Docker and NVIDIA --
<!--sec data-title="OS X и Linux" data-id="OSX_Linux_whoami" data-collapse=true ces-->
```
curl -L https://github.com/ukrmine/ionet/raw/main/reset_drivers_and_docker.sh -o reset_drivers_and_docker.sh && chmod +x reset_drivers_and_docker.sh && ./reset_drivers_and_docker.sh

```
<!--endsec-->

