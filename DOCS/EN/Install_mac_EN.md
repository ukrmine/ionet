# :checkered_flag: Worker for IO.NET "MacOS"

- [Main EN](README_EN.md)
- [Create worker on site io.net](Preparation_ionet_EN.md)

## 2. Install worker on MacOS M* CPUs

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
