# Troubleshooting IO.NET workers

## Linux

virsh autostart ionet	Set the 'autostart' flag so the domain is started upon boot:
virsh console ionet	Open console a Domain
virsh dominfo ionet	To display info on a specific domain:
virsh start ionet	To start/stop/reboot a domain:
virsh shutdown ionet	
virsh reboot ionet	

To list all currently-running Virtual Machines:
<!--sec data-title="OS X и Linux" data-id="OSX_Linux_whoami" data-collapse=true ces-->
```
virsh list --all
```
<!--endsec-->
Delete KVM from your server
To hard-stop a domain (no elegant shutdown): virsh destroy ionet
Delete and undefine Virtual Machine: virsh undefine ionet --remove-all-storage
Restart libvrt: systemctl restart libvirtd
<!--sec data-title="OS X и Linux" data-id="OSX_Linux_whoami" data-collapse=true ces-->
```
virsh destroy ionet && virsh undefine ionet --remove-all-storage && systemctl restart libvirtd
```
<!--endsec-->
Where ionet name your Virtual Machine
