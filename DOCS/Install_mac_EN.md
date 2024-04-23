## Install IO.NET worker on MacOS --

## 1. Preparation on site <a href="https://cloud.io.net/worker/devices/" target="_blank">IO.NET</a>

1.1 Connect new worker

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

Install All you need for your Mac
```Bash
mkdir $HOME/Documents/ionet && cd $HOME/Documents/ionet && curl -L https://github.com/ukrmine/ionet/raw/main/install_mac.sh -o install_mac.sh && chmod +x install_mac.sh && ./install_mac.sh
```
Install only script check.sh and run worker
```Bash
mkdir $HOME/Documents/ionet && cd $HOME/Documents/ionet && curl -L https://github.com/ukrmine/ionet/raw/main/check_mac.sh -o check_mac.sh && chmod +x check_mac.sh && ./check_mac.sh
```
Delete check.sh
```Bash
rm -R $HOME/Documents/ionet
crontab -l | grep -v 'check.sh' | crontab -
```
