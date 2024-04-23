## Install IO.NET worker on MacOS --
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
