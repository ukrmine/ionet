![Image alt](https://github.com/ukrmine/ionet/blob/main/pics/mAa0QmH3Nl9IyKqDAZzvuFNZhE0.webp)

# :checkered_flag: Scripts for IO.NET worker install

## 1. Preparation on site <a href="https://cloud.io.net/worker/devices/" target="_blank">IO.NET</a>

### 1.1 Connect new worker

![Image alt](https://github.com/ukrmine/ionet/blob/main/pics/Create_new_worker.png)


<details>
<summary>1.2 Configure new worker</summary>

1. Select Operating System “OS”
    * `Linux`
2. Select Supplier
    * `io.net`
3. Name your device
    * `Worker01`
4. Device Type
    * `CPU Worker`
5. Prerequisites for Linux
    - 5.1 Download the setup script
      * `Skip this step`
    - 5.2 Run the script
      * `Skip this step`
6. Start the containers using binary
    - 6.1 Run the command to download binary
      * `Skip this step`
    - 6.2 Run the command to launch binary
      * `Skip this step`
    - 6.3 Run the command to connect device
      * `Copy this string`

</details>

![Image alt](https://github.com/ukrmine/ionet/blob/main/pics/Configure_worker.png)

## 2. Install worker on Linux Ubuntu 20.04 server

2.1 Change user to root
```Bash
sudo -s
```

2.2 Download script and execute script to create VM for ionet worker depolyment
```Bash
cd /home && curl -L https://github.com/ukrmine/ionet/raw/main/install.sh -o install.sh && chmod +x install.sh && ./install.sh
```
<details>
<summary>2.3 Please choose</summary>
   1. Hosting or CPU type 
   2. Paste the line your Docker Command that you copied earlier in paragraph 1.2
   3. Input VM name
<details>

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

