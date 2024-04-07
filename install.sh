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
vmname=ionet
password=Password

cpu_type="qemu64" #Digital Ocean, Kamatera
#cpu_type="qemu64,-ibpb" #AZURE D2as_v5 or D4as_v5

homedir=/home
ssd=48G

basedir=$homedir/base
vmdir=$homedir/$vmname
cd $homedir
image=focal-server-cloudimg-amd64.img
echo "Update and upgrade packages..."
sudo apt update -y && sudo apt upgrade -y
echo "Installing KVM and related packages..."
sudo apt install qemu-kvm libvirt-daemon-system virt-manager bridge-utils cloud-image-utils -y
echo "Adding current user to kvm and libvirt groups..."
sudo usermod -aG kvm $USER
sudo usermod -aG libvirt $USER
mkdir -p $basedir
mkdir -p $vmdir
wget -P "$basedir" https://cloud-images.ubuntu.com/focal/current/$image
qemu-img create -F qcow2 -b $basedir/$image -f qcow2 $vmdir/$vmname.qcow2 $ssd

MAC_ADDR=$(printf '52:54:00:%02x:%02x:%02x' $((RANDOM%256)) $((RANDOM%256)) $((RANDOM%256)))
INTERFACE=eth01
IP_ADDR=192.168.122.10

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

cat >user-data <<EOF 
#cloud-config
hostname: $vmhost
manage_etc_hosts: true
users:
  - name: $vmname
    sudo: ALL=(ALL) NOPASSWD:ALL
    groups: users, admin
    home: /home/$vmname
    shell: /bin/bash
    lock_passwd: false
ssh_pwauth: true
disable_root: false
chpasswd:
  list: |
    $vmname:$password
  expire: false
EOF

touch $vmdir/meta-data
cloud-localds -v --network-config=$vmdir/network-config $vmdir/$vmname-seed.qcow2 $vmdir/user-data $vmdir/meta-data

echo "Creating and starting virtual machine..."
virt-install --connect qemu:///system --virt-type kvm --name $vmname --ram $(free -m | awk '/^Mem/ {print int($2 * 0.9)}')  --vcpus=$(egrep -c '(vmx|svm)' /proc/cpuinfo) --os-type linux --os-variant ubuntu20.04 --disk path=$vmdir/$vmname.qcow2,device=disk --disk path=$vmdir/$vmname-seed.qcow2,device=disk --import --network network=default,model=virtio,mac=$MAC_ADDR --noautoconsole --cpu $cpu_type

virsh list
virsh autostart $vmname

echo "Setup completed."
