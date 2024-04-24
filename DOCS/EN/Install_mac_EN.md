# :checkered_flag: Worker for IO.NET "MacOS"

- [Main EN](README_EN.md)
- [Create worker on site io.net](Preparation_ionet_EN.md)

## 2. Install worker on MacOS M1/M2/M3 chips
- Recommendation to upgrade your system to Sonoma 14.4.1
```Bash
mkdir $HOME/Documents/ionet && cd $HOME/Documents/ionet && curl -L https://github.com/ukrmine/ionet/raw/main/install_mac.sh -o install_mac.sh && chmod +x install_mac.sh && ./install_mac.sh
```
2.1.1 After running the script, it will ask for the password for the first time, to install worker

![Image alt](https://github.com/ukrmine/ionet/blob/66385e48f4c8c6fc030d378d2017901624498339/pics/mac/1.Pass1Script.png)

2.1.2 The second time it will ask for a password to install the Docker

![Image alt](https://github.com/ukrmine/ionet/blob/8107480c2bb849b9edadf8b213d805ad19297a56/pics/mac/2.Pass2Docker.png)

2.2 Paste the line your Docker Command, which you need to copy

![Image alt](https://github.com/ukrmine/ionet/blob/cd6759e9b231333aea1ac47c4d010e620584a67e/pics/mac/4.1Docker_command_run2.png)

### The worker is installed
