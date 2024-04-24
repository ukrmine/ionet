# Troubleshooting IO.NET Linux workers

## Linux

## -- Stopping and Remove Docker containers, Uninstall Docker and NVIDIA --
```Bash
curl -L https://github.com/ukrmine/ionet/raw/main/reset_drivers_and_docker.sh -o reset_drivers_and_docker.sh && chmod +x reset_drivers_and_docker.sh && ./reset_drivers_and_docker.sh
```

To list all Virtual Machines (VM), where "ionet" name of your Virtual Machine:

```Bash
virsh list --all
```
States of VM: running, paused, shutoff
```Bash
# To start a VM
virsh start ionet

# To reboot a VM
virsh reboot ionet

# To shutdown a VM
virsh shutdown ionet
```
Delete KVM from your server, where "ionet" name of your Virtual Machine
```Bash
virsh destroy ionet && virsh undefine ionet --remove-all-storage && systemctl restart libvirtd
```

<details>
  <summary>KVM Libvirt commands</summary>

  ###
"ionet" name of your Virtual Machine
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

</details>



  [README](README.md)
  
  Made with :heart: by <a href="https://github.com/ukrmine" target="_blank">Ukrmine</a>


