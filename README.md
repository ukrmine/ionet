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

2. Download script and execute script to create VM for ionet worker depolyment

<!--sec data-title="OS X и Linux" data-id="OSX_Linux_whoami" data-collapse=true ces-->
```
cd /home && curl -L https://github.com/ukrmine/ionet/raw/main/install.sh -o install.sh && chmod +x install.sh && ./install.sh
```
<!--endsec-->

You can change (CPU type, Hostname, Login, Password, Home directory, Disk size, IP address), or leave default setings

![Image alt](https://github.com/ukrmine/ionet/blob/main/pics/install1.png)
    
4. 
5. Login to created VM put just command "noda" if you want to exit put "exit"

6. Than install yours worker on VM

To be continued !!!






