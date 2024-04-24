# :checkered_flag: Script check.sh for worker IO.NET "MacOS"

- [Main EN](README_EN.md)

## 3. Install and Delete script check.sh

Install
```Bash
# Copy and past in Terminal
mkdir $HOME/Documents/ionet && cd $HOME/Documents/ionet && curl -L https://github.com/ukrmine/ionet/raw/main/check_mac.sh -o check_mac.sh && chmod +x check_mac.sh && ./check_mac.sh
```
Delete
```Bash
# Delete script file
rm $HOME/Documents/ionet/check.sh

# Remove a script from the autoloader
crontab -l | grep -v 'check.sh' | crontab -
```
