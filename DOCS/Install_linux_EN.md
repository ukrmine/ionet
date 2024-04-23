# :checkered_flag: Install worker for IO.NET (QEMU Virtual CPU version 2.5+)

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

## 2. Install worker on Linux Ubuntu 20.04 server
2.1 Copy and paste in terminal
```Bash
# Change user to root
sudo -s

# Download script and execute script to create VM for ionet worker depolyment
cd /home && curl -L https://github.com/ukrmine/ionet/raw/main/install.sh -o install.sh && chmod +x install.sh && ./install.sh
```

<details>
<summary> 2.3 Please choose </summary>

1. Hosting or CPU type
    * `Put "1" Digital Ocean (AMD Premium)`
    * `Put "2" AZURE D2as_v5 or D4as_v5`
    * `Put "3" AZURE D2s_v5 or D4s_v5`
    * `Put "4" Google cloud N1, Kamatera`
    * `Put "5" Enter custom CPU type`
  
2. Paste the line your Docker Command that you copied earlier in paragraph 1.2-6.3
   * `./launch_binary_linux --device_id=f42ee2d8-1ae3-445e-9a63-f3eb5b75ab5a --user_id=11694796-9a22-4a58-9766-09573c0d9df9 --operating_system="Linux" --usegpus=false --device_name=dsds`
4. Name your device
   * `Worker01`

</details>

![Image alt](https://github.com/ukrmine/ionet/blob/main/pics/install.png)
    
Wait about 10-20 min.
All is done, worker was installed and configured
