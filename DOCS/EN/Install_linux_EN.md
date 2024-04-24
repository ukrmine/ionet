# :checkered_flag: Install worker for IO.NET (QEMU Virtual CPU version 2.5+)

## 1. Preparation on site <a href="https://cloud.io.net/worker/devices/" target="_blank">IO.NET</a>


<a href="https://github.com/ukrmine/ionet/blob/main/DOCS/EN/Preparation_ionet_EN.md#1-preparation-on-site-ionet" target="_blank">Preparation ionet</a>

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
    * `Put "1" if your server is on Digital Ocean (AMD Premium)`
    * `Put "2" if your server is on AZURE D2as_v5 or D4as_v5`
    * `Put "3" if your server is on AZURE D2s_v5 or D4s_v5`
    * `Put "4" if your server is on Google cloud N1, Kamatera`
    * `Put "5" Enter custom CPU type`
  
2. Paste the line your Docker Command that you copied from <a href="https://cloud.io.net/worker/devices" target="_blank">io.net</a>  <a href="https://github.com/ukrmine/ionet/blob/main/DOCS/EN/Preparation_ionet_EN.md#63-run-the-command-to-connect-device" target="_blank">Example here</a>

   * `./launch_binary_linux --device_id=f42ee2d8-1ae3-445e-9a63-f3eb5b75ab5a --user_id=11694796-9a22-4a58-9766-09573c0d9df9 --operating_system="Linux" --usegpus=false --device_name=dsds`
4. Name your device
   * `Worker01`

</details>

![Image alt](https://github.com/ukrmine/ionet/blob/main/pics/install.png)
    
Wait about 10-20 min.
All is done, worker was installed and configured

## GUIDES

<a href="https://www.youtube.com/watch?v=Cs1ToGG2plQ" target="_blank">YouTube</a>

<a href="https://medium.com/@bitcoin_50400/how-instaling-io-net-cpu-worker-e6b528f73270" target="_blank">Medium CPU Worker</a>

<a href="https://medium.com/@bitcoin_50400/io-net-worker-on-google-cloud-7ce24c5b7797" target="_blank">Medium CPU Worker on Google Cloud</a>
