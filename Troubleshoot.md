Delete KVM from your server

virsh destroy ionet && virsh undefine ionet --remove-all-storage && systemctl restart libvirtd

Where ionet name your Virtual Machine
