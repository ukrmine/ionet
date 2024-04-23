# Troubleshooting IO.NET workers

## Linux

virsh reboot ionet	
virsh start ionet	
To list all currently-running Virtual Machines:
<!--sec data-title="OS X и Linux" data-id="OSX_Linux_whoami" data-collapse=true ces-->
```
virsh list --all
```
<!--endsec-->
Delete KVM from your server, where "ionet" name of your Virtual Machine
<!--sec data-title="OS X и Linux" data-id="OSX_Linux_whoami" data-collapse=true ces-->
```
virsh destroy ionet && virsh undefine ionet --remove-all-storage && systemctl restart libvirtd
```
<!--endsec-->



### Commands for KVM Libvirt (where "ionet" name of your Virtual Machine)
- `virsh autostart ionet`: The VM is started upon boot;
- `virsh console ionet`: Open console a VM;
- `start`: starts the application in production mode at localhost:3000 (make sure to run the build first);
- `test`: runs the tests;
- `lint`: runs eslint in the /src directory.

: 	
: 	
To display info on a specific domain: virsh dominfo ionet
To start a VM: virsh start ionet	
To shutdown VM: virsh shutdown ionet	
To reboot VM: virsh reboot ionet	
To list all currently-running Virtual Machines: virsh list --all
To hard-stop a domain (no elegant shutdown): virsh destroy ionet
Delete and undefine Virtual Machine: virsh undefine ionet --remove-all-storage
Restart libvrt: systemctl restart libvirtd
