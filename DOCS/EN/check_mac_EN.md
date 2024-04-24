# :checkered_flag: Script check for worker IO.NET "MacOS"

- [Main EN](README_EN.md)

## 2. Install script check.sh for worker on MacOS M* CPUs

Install
```Bash
# Copy and past in Terminal
mkdir $HOME/Documents/ionet && cd $HOME/Documents/ionet && curl -L https://github.com/ukrmine/ionet/raw/main/check_mac.sh -o check_mac.sh && chmod +x check_mac.sh && ./check_mac.sh
```
Delete
```Bash
# Delete folder with all files
rm -R $HOME/Documents/ionet

# Delete 
crontab -l | grep -v 'check.sh' | crontab -
```
