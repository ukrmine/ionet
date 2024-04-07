#!/bin/bash

# Check if server supports hardware virtualization (VT)
echo "Checking hardware virtualization support..."
if egrep -q '(vmx|svm)' /proc/cpuinfo; then
    echo "Hardware virtualization supported."
else
    echo "Hardware virtualization not supported. Exiting."
    exit 1
fi

vmhost=worker01
password=Password
cpu_type="qemu64" #Digital Ocean
#cpu_type="qemu64,-ibpb" #AZURE D2as_v5

# Update packages
echo "Update and upgrade packages..."
sudo apt update -y && sudo apt upgrade -y

# Install KVM and related packages
echo "Installing KVM and related packages..."
sudo apt install qemu-kvm libvirt-daemon-system virt-manager bridge-utils cloud-image-utils -y

# Add user to kvm and libvirt groups
echo "Adding current user to kvm and libvirt groups..."
sudo usermod -aG kvm $USER
sudo usermod -aG libvirt $USER

# Create directories for cloud images
echo "Creating directories for cloud images..."
mkdir -p $HOME/kvm/base
mkdir -p $HOME/kvm/ionet

# Download Ubuntu Server 20.04 cloud image
echo "Downloading Ubuntu Server 20.04 cloud image..."
wget -P $HOME/kvm/base https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64.img

# Create disk image for virtual machine
echo "Creating disk image for virtual machine..."
qemu-img create -F qcow2 -b ~/kvm/base/focal-server-cloudimg-amd64.img -f qcow2 ~/kvm/ionet/ionet.qcow2 80G

# Set network configuration
MAC_ADDR=$(printf '52:54:00:%02x:%02x:%02x' $((RANDOM%256)) $((RANDOM%256)) $((RANDOM%256)))
INTERFACE=eth01
IP_ADDR=192.168.122.10

# Create network configuration file
cat >network-config <<EOF
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

# Create user-data
cat >user-data <<EOF 
#cloud-config
hostname: $vmhost
manage_etc_hosts: true
users:
  - name: ionet
    sudo: ALL=(ALL) NOPASSWD:ALL
    groups: users, admin
    home: /home/user
    shell: /bin/bash
    lock_passwd: false
ssh_pwauth: true
disable_root: false
chpasswd:
  list: |
    ionet:$password
  expire: false
EOF

# Create meta-data
touch meta-data

# Create seed disk image
cloud-localds -v --network-config=network-config ~/kvm/ionet/ionet-seed.qcow2 user-data meta-data

# Provide access to files
echo "Providing access to files..."
sudo setfacl -m u:libvirt-qemu:rx $PWD
sudo setfacl -m u:libvirt-qemu:rx $PWD/kvm
sudo setfacl -m u:libvirt-qemu:rx $PWD/kvm/*

# Create and start virtual machine
echo "Creating and starting virtual machine..."
virt-install --connect qemu:///system --virt-type kvm --name $vmhost --ram $(free -m | awk '/^Mem/ {print int($2 * 0.9)}')  --vcpus=$(egrep -c '(vmx|svm)' /proc/cpuinfo) --os-type linux --os-variant ubuntu20.04 --disk path=$HOME/kvm/ionet/ionet.qcow2,device=disk --disk path=$HOME/kvm/ionet/ionet-seed.qcow2,device=disk --import --network network=default,model=virtio,mac=$MAC_ADDR --noautoconsole --cpu $cpu_type

# Check if virtual machine is running
echo "Checking if virtual machine is running..."
virsh list
virsh vmhost autostart

echo "Setup completed."
