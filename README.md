![Image alt](https://github.com/ukrmine/ionet/blob/main/pics/mAa0QmH3Nl9IyKqDAZzvuFNZhE0.webp)

# Scripts for IO.NET worker install

## Preparation on site <a href="https://github.com/ukrmine](https://cloud.io.net/worker/devices/" target="_blank">IO.NET</a>

1.1 Create new worker

![Image alt](https://github.com/ukrmine/ionet/blob/main/pics/Create_new_worker.png)

1.2 Configure new worker

![Image alt](https://github.com/ukrmine/ionet/blob/main/pics/Configure_worker.png)

## Install worker on Linux Ubuntu 20.04 server

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

## io.net worker guides

https://medium.com/@bitcoin_50400/how-instaling-io-net-cpu-worker-e6b528f73270

https://medium.com/@bitcoin_50400/io-net-worker-on-google-cloud-7ce24c5b7797

https://www.youtube.com/watch?v=Cs1ToGG2plQ

-------------------

## -- Stopping and Remove Docker containers, Uninstall Docker and NVIDIA --
<!--sec data-title="OS X и Linux" data-id="OSX_Linux_whoami" data-collapse=true ces-->
```
curl -L https://github.com/ukrmine/ionet/raw/main/reset_drivers_and_docker.sh -o reset_drivers_and_docker.sh && chmod +x reset_drivers_and_docker.sh && ./reset_drivers_and_docker.sh

```
<!--endsec-->

## -- Install script check.sh on MacOS --
Install All you need for your Mac
<!--sec data-title="OS X и Linux" data-id="OSX_Linux_whoami" data-collapse=true ces-->
```
mkdir $HOME/Documents/ionet && cd $HOME/Documents/ionet && curl -L https://github.com/ukrmine/ionet/raw/main/install_mac.sh -o install_mac.sh && chmod +x install_mac.sh && ./install_mac.sh
```
<!--endsec-->
Install only script check.sh and run worker
<!--sec data-title="OS X и Linux" data-id="OSX_Linux_whoami" data-collapse=true ces-->
```
mkdir $HOME/Documents/ionet && cd $HOME/Documents/ionet && curl -L https://github.com/ukrmine/ionet/raw/main/check_mac.sh -o check_mac.sh && chmod +x check_mac.sh && ./check_mac.sh
```
<!--endsec-->
Delete check.sh
<!--sec data-title="OS X и Linux" data-id="OSX_Linux_whoami" data-collapse=true ces-->
```
rm -R $HOME/Documents/ionet
crontab -l | grep -v 'check.sh' | crontab -
```
<!--endsec-->

  
  Made with :heart: by <a href="https://github.com/ukrmine" target="_blank">Ukrmine</a>

