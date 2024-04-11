#!/bin/bash

# Check if server supports hardware virtualization (VT)
echo "Checking hardware virtualization support..."
if egrep -q '(vmx|svm)' /proc/cpuinfo; then
    echo "Hardware virtualization supported."
else
    echo "Hardware virtualization NOT SUPPORTED. Exiting."
    exit 1
fi

# Default variables
vmhost="worker01"
vmname="ionet"
password="Password"
homedir="/home"
ssd="48G"
IP_ADDR="192.168.122.10"
launch=""

# Function to select CPU type
select_cpu_type() {
    echo "Select CPU type:"
    echo "1. Digital Ocean AMD Premium"
    echo "2. AZURE D2as_v5 or D4as_v5"
    echo "3. AZURE D2s_v5 or D4s_v5"
    echo "4. Google cloud N1, Kamatera"
    echo "5. Enter custom CPU type"

    read -p "Enter option number: " choice

    case $choice in
        1)
            cpu_type="qemu64"
            ;;
        2)
            cpu_type="qemu64,-ibpb"
            ;;
        3)
            cpu_type="qemu64,-svm,-spec-ctrl,-ssbd"
            ;;
        4)
            cpu_type="qemu64,-svm"
            ;;
        5)
            read -p "Enter your custom CPU type: " custom_cpu_type
            cpu_type="$custom_cpu_type"
            ;;
        *)
            echo "Setting CPU type to default: qemu64."
            cpu_type="qemu64"
            ;;
    esac
}

# Function to select other variables
select_variables() {
    read -p "Enter virtual host name (default: $vmhost): " vmhost_input
    vmhost="${vmhost_input:-$vmhost}"
    read -p "Enter password (default: $password): " password_input
    password="${password_input:-$password}"
    read -p "Enter your Docker Command (default: $launch): " launch_input
    launch="${launch_input:-$launch}" 
}

select_cpu_type
select_variables

# Output selected CPU type and other variables
echo "Selected CPU type: $cpu_type"
echo "Virtual host name: $vmhost"
echo "Virtual machine name: $vmname"
echo "Password: $password"
echo "Home directory: $homedir"
echo "SSD size: $ssd"
echo "IP address: $IP_ADDR"

basedir=$homedir/base
vmdir=$homedir/$vmname
cd $homedir
image=focal-server-cloudimg-amd64.img
echo "Update and upgrade packages..."
sudo apt update -y && sudo apt upgrade -y
echo "Installing KVM and related packages..."
sudo apt install qemu-kvm libvirt-daemon-system virt-manager bridge-utils cloud-image-utils -y
sudo usermod -aG kvm $USER
sudo usermod -aG libvirt $USER
mkdir -p $basedir $vmdir
if [ ! -f "$basedir/$image" ]; then
  wget -P "$basedir" https://cloud-images.ubuntu.com/focal/current/$image
fi
qemu-img create -F qcow2 -b $basedir/$image -f qcow2 $vmdir/$vmname.qcow2 $ssd
if [[ -z "virsh net-list --all | grep "default\s*active"" ]]; then
    echo "Network 'default' is not active. Starting the network..."
    virsh net-start default
else
    echo "Network 'default' is active."
fi
sudo -u root ssh-keygen -t rsa -b 2048 -f "/root/.ssh/id_rsa" -N ""
ssh_key=$(cat /root/.ssh/id_rsa.pub)
echo "alias noda='ssh root@$IP_ADDR'" >> /root/.bashrc
echo "alias nodacheck='ssh root@$IP_ADDR '/root/check.sh''" >> /root/.bashrc
echo "alias nodarerun='ssh root@$IP_ADDR '/root/rerun.sh''" >> /root/.bashrc
echo "alias nodadocker='ssh root@$IP_ADDR "docker ps"'" >> /root/.bashrc
echo "alias nodaspeed='ssh root@$IP_ADDR "speedtest"'" >> /root/.bashrc
. ~/.bashrc
MAC_ADDR=$(printf '52:54:00:%02x:%02x:%02x' $((RANDOM%256)) $((RANDOM%256)) $((RANDOM%256)))
INTERFACE=eth01

cat >$vmdir/network-config <<EOF
ethernets:
    $INTERFACE:
        addresses:
        - $IP_ADDR/24
        dhcp4: false
        gateway4: 192.168.122.1
        match:
            macaddress: $MAC_ADDR
        nameservers:
            addresses:
            - 1.1.1.1
            - 8.8.8.8
        set-name: $INTERFACE
version: 2
EOF

cat >$vmdir/user-data <<EOF 
#cloud-config
hostname: $vmhost
manage_etc_hosts: true
users:
  - name: root
    shell: /bin/bash
    lock-passwd: false
    ssh-authorized-keys:
      - $ssh_key
ssh_pwauth: true
disable_root: false
chpasswd:
  list: |
    root:$password
  expire: false
write_files:
  - path: /root/script.sh
    permissions: '0755'
    content: |
      #!/bin/bash
      sed -i "s/#Port 22/Port 22/" /etc/ssh/sshd_config
      sed -i 's/^#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
      sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
      curl -L -o /root/ionet-setup.sh https://github.com/ionet-official/io-net-official-setup-script/raw/main/ionet-setup.sh
      curl -L -o /root/launch_binary_linux https://github.com/ionet-official/io_launch_binaries/raw/main/launch_binary_linux
      curl -L -o /root/check.sh https://github.com/ukrmine/ionet/raw/main/check.sh
      curl -L -o /root/rerun.sh https://github.com/ukrmine/ionet/raw/main/rerun.sh
      sed -i "s|launch_string=.*|launch_string=\"$launch\"|" /root/check.sh
      sed -i "s|launch_string=.*|launch_string=\"$launch\"|" /root/rerun.sh
      chmod +x /root/launch_binary_linux && chmod +x /root/check.sh
      chmod +x /root/ionet-setup.sh && /root/ionet-setup.sh
      chmod +x /root/rerun.sh && /root/rerun.sh
      curl -s https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.deb.sh | sudo bash
      apt install -y speedtest
runcmd:
  - [ bash, "/root/script.sh" ]
  - service ssh reload
  - rm /root/script.sh
EOF

touch $vmdir/meta-data
cloud-localds -v --network-config=$vmdir/network-config $vmdir/$vmname-seed.qcow2 $vmdir/user-data $vmdir/meta-data

echo "Creating and starting virtual machine..."
virt-install --connect qemu:///system --virt-type kvm --name $vmname --ram $(free -m | awk '/^Mem/ {print int($2 * 0.9)}')  --vcpus=$(egrep -c '(vmx|svm)' /proc/cpuinfo) --os-type linux --os-variant ubuntu20.04 --disk path=$vmdir/$vmname.qcow2,device=disk --disk path=$vmdir/$vmname-seed.qcow2,device=disk --import --network network=default,model=virtio,mac=$MAC_ADDR --noautoconsole --cpu $cpu_type

virsh list
virsh autostart $vmname

echo "Login to VM enter "noda""
echo "Check Docker containers "nodadocker""
echo "Check Connectivity Tier "nodaspeed""
echo "Check worker "nodacheck""
echo "Rerun worker "nodarerun""
echo "Setup completed."
