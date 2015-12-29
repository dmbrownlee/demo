# This make file creates a package file for vagrant called UbuntuServer1504.box
# from an existing VirtualBox VM named "Ubuntu Server 64-bit 15.04" and adds it
# to the list of available packagees in vagrant.  If a package already exists
# with the same name, it is replaced.

.PHONY:cleanvm
.PHONY:newvm
.PHONY:vboxext
.PHONY:vagrant
.PHONY:package

#VM = CentOS-7-x86_64-Minimal-1511
ISODIR := $(HOME)/vm/basebox/iso

help:
	@echo ""
	@echo "This make file is used to build vagrant base boxes.  The"
	@echo "typical steps are:"
	@echo ""
	@echo "  export VM=<VM>"
	@echo "    (where <VM> is the ISO filename without the .iso extension)"
	@echo "  make newvm	(create the VM and install the OS)"
	@echo "  make vboxext	(add the VirtualBox guest extensions)"
	@echo "  make vagrant	(add the vagrant user account)"
	@echo "  make package	(create the basebox)"
	@echo ""
	@echo "Start by running \"make newvm\" and follow the steps echoed"
	@echo "to the terminal."
	@echo ""

#==============================================================================
# Verify that $VM is set
#==============================================================================
$(VM).isset:
	@if [[ -z "$(VM)" ]]; then echo "You must set the VM environment variable"; exit 1; fi
	export ISO=$(VM).iso

#==============================================================================
# Print warning and exit if the ISO file does not exist
#==============================================================================
$(ISODIR)/$(ISO):
	@echo "You need to download $(ISO) to the $(ISODIR) directory"
	@exit 1

#==============================================================================
# Remove the exiting VM with the same name (if any)
#==============================================================================
cleanvm:
	#======================================================================
	# Delete the "$(VM)" VM (if it exists)
	#======================================================================
	-vboxmanage controlvm "$(VM)" poweroff
	-vboxmanage unregistervm "$(VM)" --delete
	-vboxmanage closemedium disk "$(HOME)/VirtualBox VMs/$(VM)/box-disk1.vmdk" --delete

#==============================================================================
# Build the VM
#==============================================================================
newvm: $(VM).isset $(ISODIR)/$(ISO) cleanvm
	#======================================================================
	# (Re)create "$(VM)" VM
	#======================================================================
	vboxmanage createvm --name "$(VM)" --register --ostype RedHat_64
	vboxmanage modifyvm "$(VM)" --memory 768 --vram 12 --pae off --boot1 dvd --boot2 disk --boot3 none --rtcuseutc on --mouse usbtablet --clipboard bidirectional --usb on --nestedpaging on
	vboxmanage storagectl "$(VM)" --name IDE --add ide --controller PIIX4 --portcount 2 --bootable on
	vboxmanage storagectl "$(VM)" --name SATA --add sata --controller IntelAHCI --portcount 1 --bootable on
	vboxmanage createhd --filename "$(HOME)/VirtualBox VMs/$(VM)/box-disk1.vmdk" --size 8192 --format VMDK
	vboxmanage storageattach "$(VM)" --storagectl IDE --port 1 --device 0 --type dvddrive --medium $(ISODIR)/$(ISO)
	vboxmanage storageattach "$(VM)" --storagectl SATA --port 0 --device 0 --type hdd --medium "$(HOME)/VirtualBox VMs/$(VM)/box-disk1.vmdk" --hotpluggable on
	vboxmanage startvm "$(VM)"
	@echo ""
	@echo "The VM for the basebox has been created and the OS installer"
	@echo "has been launched.  Do the following:"
	@echo ""
	@echo "  - Install a minimal OS as you normally would"
	@echo "  - Shutdown the VM"
	@echo "  - Run \"make vboxext\" to begin the next step"
	@echo ""

#==============================================================================
# Install the guest additions
#==============================================================================
vboxext: $(VM).isset
	-vboxmanage controlvm "$(VM)" poweroff
	vboxmanage startvm "$(VM)"
	vboxmanage storageattach "$(VM)" --storagectl IDE --port 1 --device 0 --type dvddrive --medium additions
	@echo ""
	@echo "Now we need to install the Guest Addtions.  The VM has been"
	@echo "started again and the Guest Additions virtual disk is loaded."
	@echo "Login to the virtual machine, launch the terminal, and do"
	@echo "the following:"
	@echo ""
	@echo "  - Upgrade all existing packages"
	@echo "  - Install the kernel module devel tools"
	@echo "      (Ubuntu: sudo apt-get install dkms)"
	@echo "      (Centos: sudo yum install epel-release)"
	@echo "      (Centos: sudo yum install dkms)"
	@echo "  - Install the Guest Additions"
	@echo "      (Centos: sudo yum install dkms)"
	@echo "      (sudo sh /media/demouser/VBOXADDITIONS_5.0.10_104061/autorun.sh)"
	@echo "  - Add the user to the vboxsf group"
	@echo "      (sudo usermod -a -G vboxsf demouser)"
	@echo "  - Shutdown the VM"
	@echo "  - Run \"make vagrant\" to begin the next step"
	@echo ""

#==============================================================================
# Add the vagrant user
#==============================================================================
vagrant: $(VM).isset
	-vboxmanage controlvm "$(VM)" poweroff
	vboxmanage startvm "$(VM)"
	vboxmanage storageattach "$(VM)" --storagectl IDE --port 1 --device 0 --type dvddrive --medium emptydrive
	vboxmanage sharedfolder add "$(VM)" --name "vagrant_data" --hostpath "$(HOME)/vm/data" --transient --automount
	@echo ""
	@echo "Now we are going to add the vagrant user. A Makefile is in"
	@echo "the shared folder to automate this step.  Login to the"
	@echo "virtual machine, launch the terminal, and do the following:"
	@echo ""
	@echo "  - Add the vagrant user"
	@echo "      (sudo make -f /media/sf_vagrant_data/Makefile)"
	@echo "  - Make ALL other customizations you want every VMs to have"
	@echo "  - Shutdown the VM"
	@echo "  - Run \"make package\" to begin the next step"
	@echo ""

#==============================================================================
# Package the VM for Vagrant
#==============================================================================
package: $(VM).isset
	-vboxmanage controlvm "$(VM)" poweroff
	vagrant package --base "$(VM)"
	vagrant box remove "$(VM)" || true
	vagrant box add --name "$(VM)" package.box
	rm -f ./package.box
	vagrant box list
	@echo ""
	@echo "Congratulations!  You have created and installed a new basebox."
	@echo ""
