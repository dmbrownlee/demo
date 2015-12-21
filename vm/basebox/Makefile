# This make file creates a package file for vagrant called UbuntuServer1504.box
# from an existing VirtualBox VM named "Ubuntu Server 64-bit 15.04" and adds it
# to the list of available packagees in vagrant.  If a package already exists
# with the same name, it is replaced.

.PHONY:iso
.PHONY:cleanvm
.PHONY:buildvm
.PHONY:vboxext
.PHONY:vagrant
.PHONY:package

DISTRO := ubuntu
PLATFORM := desktop
ARCH := amd64
DISTRO_VERSION := 15.10
DISTRO_MIRROR := http://mirror.pnl.gov/releases

VM = $(DISTRO) $(PLATFORM) $(ARCH) $(DISTRO_VERSION)
ISO = $(DISTRO)-$(DISTRO_VERSION)-$(PLATFORM)-$(ARCH).iso

ISODIR := $(HOME)/vm/basebox

all: buildvm

#==============================================================================
# Fetch the ISO image for the install
#==============================================================================
iso:
	#======================================================================
	# Downloading $(ISO)
	#======================================================================
	if [ ! -f $(ISO) ]; then curl -O $(DISTRO_MIRROR)/$(DISTRO_VERSION)/$(ISO); fi

#==============================================================================
# Remove the exiting VM with the same name (if any)
#==============================================================================
cleanvm:
	#======================================================================
	# Delete the "$(VM)" VM (if it exists)
	#======================================================================
	-vboxmanage controlvm "ubuntu desktop amd64 15.10" poweroff
	-vboxmanage unregistervm "$(VM)" --delete
	-vboxmanage closemedium disk "$(HOME)/VirtualBox VMs/$(VM)/box-disk1.vmdk" --delete

#==============================================================================
# Build the VM
#==============================================================================
buildvm: iso cleanvm
	#======================================================================
	# (Re)create "$(VM)" VM
	#======================================================================
	vboxmanage createvm --name "$(VM)" --register --ostype Ubuntu_64
	vboxmanage modifyvm "$(VM)" --memory 768 --vram 12 --pae off --boot1 dvd --boot2 disk --boot3 none --rtcuseutc on --mouse usbtablet --clipboard bidirectional --usb on --nestedpaging on
	vboxmanage storagectl "$(VM)" --name IDE --add ide --controller PIIX4 --portcount 2 --bootable on
	vboxmanage storagectl "$(VM)" --name SATA --add sata --controller IntelAHCI --portcount 1 --bootable on
	vboxmanage createhd --filename "$(HOME)/VirtualBox VMs/$(VM)/box-disk1.vmdk" --size 8192 --format VMDK
	vboxmanage storageattach "$(VM)" --storagectl IDE --port 1 --device 0 --type dvddrive --medium $(ISODIR)/$(ISO)
	vboxmanage storageattach "$(VM)" --storagectl SATA --port 0 --device 0 --type hdd --medium "$(HOME)/VirtualBox VMs/$(VM)/box-disk1.vmdk" --hotpluggable on
	vboxmanage startvm "$(VM)"

#==============================================================================
# Install the guest additions
#==============================================================================
vboxext:
	-vboxmanage controlvm "ubuntu desktop amd64 15.10" poweroff
	vboxmanage startvm "$(VM)"
	vboxmanage storageattach "$(VM)" --storagectl IDE --port 1 --device 0 --type dvddrive --medium additions

#==============================================================================
# Add the vagrant user
#==============================================================================
vagrant:
	-vboxmanage controlvm "ubuntu desktop amd64 15.10" poweroff
	vboxmanage startvm "$(VM)"
	vboxmanage storageattach "$(VM)" --storagectl IDE --port 1 --device 0 --type dvddrive --medium emptydrive
	vboxmanage sharedfolder add "$(VM)" --name "vagrant_data" --hostpath "$(HOME)/vm/data" --transient --automount

#==============================================================================
# Package the VM for Vagrant
#==============================================================================
package:
	-vboxmanage controlvm "ubuntu desktop amd64 15.10" poweroff
	vagrant package --base "$(VM)"
	vagrant box remove "$(VM)" || true
	vagrant box add --name "$(VM)" package.box
	rm -f ./package.box
	vagrant box list
