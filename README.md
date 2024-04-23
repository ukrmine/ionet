![Image alt](https://github.com/ukrmine/ionet/blob/main/pics/mAa0QmH3Nl9IyKqDAZzvuFNZhE0.webp)

# :checkered_flag: Scripts for IO.NET 

## Install worker based on Ubuntu 20.04 "QEMU Virtual CPU version 2.5+"

- [Linux EN](DOCS/Install_linux_EN.md)
- [Linux UA](DOCS/Install_linux_UA.md)


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

