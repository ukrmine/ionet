# :checkered_flag: Worker for IO.NET "MacOS"

- [Main EN](README_EN.md)
- [Create worker on site io.net](Preparation_ionet_EN.md)

## 2. Install worker on MacOS M1/M2/M3 chips
- Recommendation to upgrade your system to Sonoma 14.4.1
Open Terminal app and put this command
```Bash
mkdir $HOME/Documents/ionet && cd $HOME/Documents/ionet && curl -L https://github.com/ukrmine/ionet/raw/main/install_mac.sh -o install_mac.sh && chmod +x install_mac.sh && ./install_mac.sh
```
2.1.1 After running the script, it will ask for the password for the first time, to install worker

![Image alt](https://github.com/ukrmine/ionet/blob/66385e48f4c8c6fc030d378d2017901624498339/pics/mac/1.Pass1Script.png)

2.1.2 The second time it will ask for a password to install the Docker

![Image alt](https://github.com/ukrmine/ionet/blob/8107480c2bb849b9edadf8b213d805ad19297a56/pics/mac/2.Pass2Docker.png)

2.2 Go to site io.net put on button "Connect new worker" and configure it



2.2 Paste the line your Docker Command, which you need to copy

![Image alt](https://github.com/ukrmine/ionet/blob/cd6759e9b231333aea1ac47c4d010e620584a67e/pics/mac/4.1Docker_command_run2.png)

2.3 The worker is installed

![Image alt](https://github.com/ukrmine/ionet/blob/b44a14d6929da27dc11e8d4e0a68c460db8332aa/pics/mac/5.Instalation_succesfuf.png)

You can wait 10-20 min and check containers
```Bash
docker ps
```
![Image alt](https://github.com/ukrmine/ionet/blob/9e1cc878f4b7ab65a1ff957c3ec63b20812a4504/pics/mac/Docker_ps_good.png)

If you see the same two containers and they work for more than 5 minutes, then everything is fine
