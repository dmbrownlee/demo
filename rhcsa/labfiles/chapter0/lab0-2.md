# lab0-2: Using the virtual lab environment

## OBJECTIVE

In this lab, we learn how to use Vagrant to manage the virtual machines in our virtual lab environment.

## SETUP

This lab assumes you have already installed the demo project and have setup the virtual lab environment for the RHCSA study group.  If you haven't done these steps already, you can use these links to find the instructions:

- [Install the demo project](https://github.com/dmbrownlee/demo/blob/master/README.md)
- [Setup the RHCSA virtual lab environment](https://github.com/dmbrownlee/demo/blob/master/rhcsa/README.md)

## BACKGROUND

[Vagrant](https://www.vagrantup.com/) is a program from Hashicorp which automates the management (creation, provisioning, deletion) of virtual machines.  This is helpful because it means we can destroy old virtual machines to save disk space and quickly create clean, new virtual machines in a consistently known good state whenever we want to do a lab.  Vagrant supports many virtualization platforms both locally and in the cloud and we will be using it to manage our virtual machines in VirtualBox.

The ```vagrant``` command requires a configuration file named ```Vagrantfile``` to exist in your current (or parent) directory for most of the commands shown here.  If you are in the wrong directory, you might see this error:

```
A Vagrant environment or target machine is required to run this
command. Run `vagrant init` to create a new Vagrant environment. Or,
get an ID of a target machine from `vagrant global-status` to run
this command on. A final option is to change to a directory with a
Vagrantfile and to try again.
```

If you see this message, make sure you change to the ```~/demo/rhcsa``` directory before running your command again.

## STEPS

### Listing available base boxes

When Vagrant creates a virtual machine, it configures the virtual hardware as specified in the ```Vagrantfile``` in the current directory and then it copies an existing disk image of a preinstalled system to the virtual machine's system drive.  Vagrant calls these preinstalled disk images "base boxes" and each base box can be used as the starting point for creating multiple virtual machines since each virtual machine gets a copy, not the original.

To see which base boxes are already installed locally and available as a starting point for the virtual machines specified in ```Vagrantfile```, run this command:

```
vagrant box list
```

You will see output like this:

```
centos-8.3.2011 (virtualbox, 0)
debian-10.6.0   (virtualbox, 0)
windows-10      (virtualbox, 0)
```

> Note: This is the one command in this lab you can run from anywhere.  For all the commands below, make sure you are in ```~/demo/rhcsa``` which is the directory containing the ```Vagrantfile``` for this study group's lab environment.

> Note: This study group uses only the ```centos-8.3.2011``` base box but you may have others which were installed from other projects and study groups.

For other projects, you can get Vagrant base boxes built by others from [Vagrant Cloud](https://app.vagrantup.com/boxes/search) or you can build your own custom base boxes using [```packer```](https://www.packer.io/), also from Hashicorp.  However, we won't be covering that in this lab.

### Checking virtual machine status

The ```Vagrantfile``` Vagrant uses as a configuration file is actually a snippet of code written in the Ruby programming language.  If you are familiar with Ruby, you may find it fairly readable but, if not, the ```vagrant status``` command is a simpler way to see the names of all the virtual machines the file defines and their current status. For this command, you must be in the ```~/demo/rhcsa directory``` so we will run the following:

```
cd ~/demo/rhcsa && vagrant status
```

This results in the following output:

```
Current machine states:

server1                   not created (virtualbox)
server2                   not created (virtualbox)
installhost               not created (virtualbox)
exam1                     not created (virtualbox)
exam2                     not created (virtualbox)

This environment represents multiple VMs. The VMs are all listed
above with their current state. For more information about a specific
VM, run `vagrant status NAME`.
```

As you can see, our ```Vagrantfile``` defines five virtual machines, none of which are currently created.

### Creating and starting virtual machines

The ```vagrant up``` command is used to start the virtual machines in your ```Vagrantfile```.  If the virtual machines have already been created, ```vagrant up``` will just start them if they are not currently running.  If the virtual machines have not been created, ```vagrant up``` will create the virtual machines, start them, and connect to them in order to run provisioning scripts to customize each one.

You can use ```vagrant up``` followed by the names of one or more virtual machines names (as returned by ```vagrant status```) to create and/or start specific virtual machines.  If you run ```vagrant up``` without any virtual machine names, then all virtual machines defined in the ```Vagrantfile``` will be created and/or started unless they explicitly have autostart set to false in their definition.

Let's create and start all the default virtual machines now with:

```
vagrant up
```

This command will take a few minutes as it creates server1 and server2.  In the output, you will see vagrant copying the base box, booting the virtual machine, and waiting for it to be accessible via SSH.  Vagrant will then connect to the virtual machine via SSH and run an Ansible playbook to configure the virtual machine for its specific purpose.

```
Bringing machine 'server1' up with 'virtualbox' provider...
Bringing machine 'server2' up with 'virtualbox' provider...
==> server1: Importing base box 'centos-8.3.2011'...
==> server1: Matching MAC address for NAT networking...
==> server1: Setting the name of the VM: rhcsa_server1
==> server1: Clearing any previously set network interfaces...
==> server1: Preparing network interfaces based on configuration...
    server1: Adapter 1: nat
==> server1: Forwarding ports...
    server1: 22 (guest) => 2222 (host) (adapter 1)
==> server1: Running 'pre-boot' VM customizations...
==> server1: Booting VM...
==> server1: Waiting for machine to boot. This may take a few minutes...
    server1: SSH address: 127.0.0.1:2222
    server1: SSH username: vagrant
    server1: SSH auth method: private key
==> server1: Machine booted and ready!
==> server1: Checking for guest additions in VM...
==> server1: Mounting shared folders...
    server1: /labfiles => /Users/user/demo/rhcsa/labfiles
    server1: /coursefiles => /Users/user/demo/rhcsa/coursefiles
==> server1: Running provisioner: ansible...
    server1: Running ansible-playbook...

PLAY [Common configuration] ****************************************************
```
*(output from Ansible provisioning playbook follows...)*

> Note: All virtual machines in our environment other than server1 and server2 have autostart explicitly set to false.  If you want to create them, you have to specify them by name when using ```vagrant up```.
> Note: server2 will be created after server1 is finished.  In VirtualBox environments, Vagrant starts up virtual machines serially, not in parallel.
> Note: If you want your virtual machines to be in a known good state, I recommend you wait until the provisioning playbooks have finished before you login so that you don't accidentally do something that would cause the playbook to fail.

If you run ```vasgrant status``` again, you will see the two virtual machines are created and running.  At this point, you can start the VirtualBox graphical interface, open a console to your virtual machines from there, and login.

Normally, ```vagrant up``` only runs the provisioning scripts when the virtual machine is created.  If the provisioning scripts get updated and you would like to run them again, you can either destroy the virtual machine (see below) and run ```vagrant up``` again or you can force the provisioning scripts to run when you start an existing virtual machine with ```vagrant up --provision``` followed by the name of the virtual machine.  Should you need it for some reason, there is also ```vagrant up --no-provision``` if you want to create/start a virtual machine without running the provisioning scripts.

Vagrant is really about saving time and avoiding mistakes when creating virtual machines.  Once the virtual machines are created, you can also just start the virtual machines from the VirtualBox graphical app, but ```vagrant up``` might still be faster if you're starting several virtual machines at once.

### Shutting down or rebooting the virtual machines

You can quickly shutdown all the running virtual machines with ```vagrant halt``` or shutdown just one virtual machine by running the same command followed by the name of the virtual machine you want to stop.  This will shutdown the virtual machines but they will still exist in VirtualBox and can be restarted either from the VirtualBox graphical app or from the command line with ```vagrant up```.  You could also login to each virtual machine and use the operating systems shutdown commands, but ```vagrant halt``` is faster and easier, especially when you're shutting down more than one virtual machine.

Similarly, you can use ```vagrant reload``` to reboot one or all the virtual machines.  This is equivalent to running ```vagrant halt``` followed by ```vagrant up```.

Try these commands out now:

```
vagrant reload
vagrant halt server2
vagrant status
```

### Destroying virtual machines

Since it is easy to quickly create virtual machines, there isn't much reason to keep them around when you're done with them if they don't contain data you want to save.  You can completely remove the virtual machines with ```vagrant destroy``` and that will delete all the virtual machines, including removing their virtual disks, so you can free up disk space on your host.  Since this is a destructive command and there is no way to get back any data that might be in the virtual machines' disks, you will be asked if you are sure you want to do this.  Just type 'y' and press enter to confirm.  If you find these warning prompts annoying, you can disable them by using ```vagrant destroy -f``` (-f for "force") and Vagrant will remote the virtual machine without hesitation.

> Tip: You do not need to halt the virtual machines before destroying them, the destroy command will first halt any running virtual machines.

> Note: ```vagrant destroy``` removes virtual machines but does not remove the base boxes used to create them so they are easy to recreate.

Try these commands out now:

```
vagrant destroy server2
vagrant status
vagrant up server2
vagrant status
```

### Updating Vagrant base boxes

> Note: We likely won't need to update the Vagrant base boxes for the duration of the study group so consider this overview just an FYI.  See the [packer website](https://www.packer.io/) for the full documentation on building custom base boxes for Vagrant.

If a new version of the operating system is released, we might want to upgrade following these steps:

1. Use ```packer build```*```<.json file>```* to build a base box for the new version of the OS
1. Use ```vagrant box add --name```*```<name>```* *```<.box file>```* to add the new base box to Vagrant's box repository
1. Destroy any existing virtual machines based on the old base box using ```vagrant destroy```
1. Update ```Vagrantfile``` to use the new base box (this should be done in the Ansible template)
1. Use ```vagrant up``` to recreate the virtual machines

Once these steps have been completed, if you no longer have a need for the old base box, you can remove it with ```vagrant box remove <name>``` (where *```<name>```* is the name of the box as returned by ```vagrant box list```).

With regards to building the Vagrant base boxes, our initial base boxes were built and installed by Ansbile when we ran ```cd ~/demo && git pull && ./setup rhcsa```.  While it is great to have this automated, the packer ouput when there is an error is difficult to read when it is wrapped in an Ansible tasks.  You can build the base boxes manually with:

```
cd ~/demo/ansible/packer && packer build centos-8.3.2011.json
```

The ```packer build``` command uses the instructions in the ```.json``` file to download the installation media, create a virtual machine, install the operating system and customize it for use with Vagrant, shutdown the virtual machine, and, finally, package the virtual machine's hard disk file into a Vagrant base box file with a ```.box``` extension.  This base box file can be added to Vagrant's base box repository with the ```vagrant box add``` command.

## CONFIRMATION

You will know you have completed this lab successfully when the following are true:

  1. You recognize when Vagrant says you're in the wrong directory and know which file to look for to confirm you are in the correct directory.
  1. You know how to check the current status of your virtual machines from the command line.
  1. You can create one or more virtual machines with a single command
  1. You can quickly stop and reboot your virtual machines
  1. You can destroy remove your virtual machines from the command line when you no longer need them.
  1. You have only two virtual machines, server1 and server2 (the others are not created automatically when you run ```vagrant up``` and you don't need them yet)
