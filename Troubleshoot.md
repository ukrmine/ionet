# Troubleshooting IO.NET workers

## Linux

Delete KVM from your server
<!--sec data-title="OS X и Linux" data-id="OSX_Linux_whoami" data-collapse=true ces-->
```
virsh destroy ionet && virsh undefine ionet --remove-all-storage && systemctl restart libvirtd
```
<!--endsec-->
Where ionet name your Virtual Machine
