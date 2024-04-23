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
```Bash
virsh destroy ionet && virsh undefine ionet --remove-all-storage && systemctl restart libvirtd
```



### Commands for KVM Libvirt (where "ionet" name of your Virtual Machine)
- `virsh autostart ionet`: The VM is started upon boot;
- `virsh console ionet`: Open console a VM;
- `virsh dominfo ionet`: To display info on a specific VM;
- `virsh start ionet`: To start a VM;
- `virsh shutdown ionet`: To shutdown a VM;
- `virsh reboot ionet`: To reboot a VM;
- `virsh list --all`: To list all currently-running VM;
- `virsh destroy ionet`: To hard-stop a VM (no elegant shutdown);
- `virsh undefine ionet --remove-all-storage`: Delete and undefine VM;
- `systemctl restart libvirtd`: Restart libvrt service.

  [README](README.md)
  
  Made with :heart: by <a href="https://github.com/maurodesouza" target="_blank">Mauro de Souza</a>


