# :checkered_flag: Worker(noda) for IO.NET 

## 1. Preparation on site <a href="https://cloud.io.net/worker/devices/" target="_blank">IO.NET</a>

* ### [Creating worker on io.net](Preparation_ionet_EN.md)

## 2. Installation worker
* ### [Ubuntu 20.04 QEMU Virtual CPU version 2.5+](Install_linux_EN.md)
* ### [MacOS Apple M* CPUs](Install_mac_EN.md)

## 3. Scripts
* ### [MacOS install check.sh script for checking worker status](check_mac_EN.md)

```Bash
# Download script check.sh and execute script
curl -L -o check.sh https://github.com/ukrmine/ionet/raw/main/check.sh && chmod +x check.sh && ./check.sh

#Add two rules
#1. Run the script every 10 minutes
#2. Restart the worker at night
crontab<<EOF
*/10 * * * * /root/check.sh
03 03 * * * /root/check.sh -r
EOF
```

  
  Made with :heart: by <a href="https://github.com/ukrmine" target="_blank">Ukrmine</a>

