# This make file creates a package file for vagrant called UbuntuServer1504.box
# from an existing VirtualBox VM named "Ubuntu Server 64-bit 15.04" and adds it
# to the list of available packagees in vagrant.  If a package already exists
# with the same name, it is replaced.

.PHONY:clean
.PHONY:vm
.PHONY:config
.PHONY:install

#VM = CentOS-7-x86_64-Minimal-1511
ISODIR := $(HOME)/vm/basebox/iso
SSHPORT := 2268

help:
	@echo ""
	@echo "This make file is used to build vagrant baseboxes.  The steps"
	@echo "are:"
	@echo ""
	@echo "  export VM=<VM>"
	@echo "    (where <VM> is the ISO filename without the .iso extension)"
	@echo "  make vm	(create the VM and install the OS)"
	@echo "  make config	(use ansible to configure the VM for vagrant)"
	@echo "  make install	(create the basebox from the VM and install it)"
	@echo ""
	@echo "You may also wish to start by running \"make clean\" to remove"
	@echo "a VM with the same name from a previous basebox build."
	@echo ""

#==============================================================================
# Verify that $VM is set
#==============================================================================
$(VM).isset:
	@if [[ -z "$(VM)" ]]; then echo "You must set the VM environment variable"; exit 1; fi

#==============================================================================
# Print warning and exit if the ISO file does not exist
#==============================================================================
$(ISODIR)/$(VM).iso:
	@echo "You need to download $(VM).iso to the $(ISODIR) directory"
	@exit 1

#==============================================================================
# Remove the exiting VM with the same name (if any)
#==============================================================================
clean:
	#======================================================================
	# Delete the "$(VM)" VM (if it exists)
	#======================================================================
	-vboxmanage controlvm "$(VM)" poweroff
	-vboxmanage unregistervm "$(VM)" --delete
	-vboxmanage closemedium disk "$(HOME)/VirtualBox VMs/$(VM)/box-disk1.vmdk" --delete

#==============================================================================
# Create the VM
#==============================================================================
vm: $(VM).isset $(ISODIR)/$(VM).iso
	#======================================================================
	# (Re)create "$(VM)" VM
	#======================================================================
	vboxmanage createvm --name "$(VM)" --register --ostype RedHat_64
	vboxmanage modifyvm "$(VM)" --memory 768 --vram 12 --pae off --boot1 dvd --boot2 disk --boot3 none --rtcuseutc on --mouse usbtablet --clipboard bidirectional --usb on --nestedpaging on
	vboxmanage modifyvm "$(VM)" --natpf1 "ssh,tcp,127.0.0.1,$(SSHPORT),,22"
	vboxmanage storagectl "$(VM)" --name IDE --add ide --controller PIIX4 --portcount 2 --bootable on
	vboxmanage storagectl "$(VM)" --name SATA --add sata --controller IntelAHCI --portcount 1 --bootable on
	vboxmanage createhd --filename "$(HOME)/VirtualBox VMs/$(VM)/box-disk1.vmdk" --size 8192 --format VMDK
	vboxmanage storageattach "$(VM)" --storagectl IDE --port 1 --device 0 --type dvddrive --medium $(ISODIR)/$(VM).iso
	vboxmanage storageattach "$(VM)" --storagectl SATA --port 0 --device 0 --type hdd --medium "$(HOME)/VirtualBox VMs/$(VM)/box-disk1.vmdk" --hotpluggable on
	vboxmanage startvm "$(VM)"
	@echo ""
	@echo "The VM for the basebox has been created and the OS installer"
	@echo "has been launched.  Do the following:"
	@echo ""
	@echo "  - Install a minimal OS and make sure you install openssh-server and python"
	@echo "  - Run \"make config\" to begin the next step"
	@echo ""

#==============================================================================
# Use ansible to configure the VM
#==============================================================================
config:
	ansible-playbook -i inventory.basebox -e 'host_key_checking=False' --ssh-extra-args '-o UserKnownHostsFile=/dev/null' --user=demouser --ask-pass --ask-become-pass basebox.yml
	@echo ""
	@echo "Ansible has configured the VM for use with Vagrant.  Assuming"
	@echo "all your basebox customizations are done by ansible (as they"
	@echo "should be), all that is left is to packed the basebox and"
	@echo "install it."
	@echo ""
	@echo "  - Run \"make install\""
	@echo ""

#==============================================================================
# Package the VM for Vagrant
#==============================================================================
install: $(VM).isset
	-vboxmanage controlvm "$(VM)" poweroff
	vagrant package --base "$(VM)"
	vagrant box remove "$(VM)" || true
	vagrant box add --name "$(VM)" package.box
	rm -f ./package.box
	vagrant box list
	@echo ""
	@echo "Congratulations!  You have created and installed a new basebox."
	@echo ""
