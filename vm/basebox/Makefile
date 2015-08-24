# This make file creates a basebox file for vagrant called UbuntuServer1504.box
# from an existing VirtualBox VM named "Ubuntu Server 64-bit 15.04" and adds it
# to the list of available baseboxes in vagrant.  If a basebox already exists
# with the same name, it is replaced.

.PHONY:basebox

.PHONY:clean

BASEVM	:= "Ubuntu Server 64-bit 15.04"
BASEBOX	:= "UbuntuServer1504.box"

all: clean basebox

basebox:
	vagrant package --base $(BASEVM)
	mv ./package.box $(BASEBOX)
	vagrant box add --name $(BASEVM) $(BASEBOX)
	vagrant box list

clean:
	rm -f ./package.box $(BASEBOX)
	vagrant box remove $(BASEVM) || true

