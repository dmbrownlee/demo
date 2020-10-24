# Finding information about your Ethernet interface in Linux (with an unrelated introduction to Vagrant)
In this lab, we will take a look a how to find information about your Ethernet interface in Linux. Rather than do this in GNS3 with Linux Docker containers as in previous labs, we will take this opportunity to spin up full Linux installations in VirtualBox and learn to integrate these into our GNS3 network models.  Along the way, we will learn about Packer and Vagrant, two free, cross-platform tools from Hashicorp that help us quickly spin up virtual machines and discard them when we are done with them.

## Setup
First, let's get a quick introduction to some of the tools we have available.
- *[Ansible](https://docs.ansible.com/ansible/latest/index.html)*
    Ansible is a configuration management tool.  It can install software, add users and groups, enable server processes, manage file systems, configure firewalls and network iterfaces, and all sorts of other configuration tasks an admin might do on the local system as well as on remote machines you manage.  Ansible reads a series of tasks from a playbook.  These playbooks are simple text files written in the *YAML* language with each task declaring the state the machine should be in.  For example, a playbook might say user Linda should exist on the system and the nginx web server should be installed and running.  When ansible runs, it compares the state the machine is currently in to what you said you wanted in the playbook and it will make any changes necessary.  You don't need to tell Ansible how to check the state or how to make the changes, it already know that.  You just need to tell it what you want.  The setup script for the demo project is a small shell script that ensures Ansible is installed before running Ansible with a playbook to install the rest of the software.
- *[Vagrant](https://www.vagrantup.com/)*
    We are using VirtualBox as the virualization platform for our virtual machines.  If you have used VirtualBox, VMWare or similar before, you may be familiar with creating virtual machines by hand.  Typically, you would click New Virtual Machine in a GUI, select the virtual hardware including amount of RAM, number of CPUs and disks, etc.  Then you would "insert" the ISO image of the operating system's install disk into the virtual DVD drive and boot the VM.  From there, you would install the operating system as you would on physical hardware.  Once the install is complete, you might install additional software for your particular use case and make some custom tweaks so the UI works the way you want it to.  When you finally have it just the way you want it, if you're smart, you'll make a snapshot of the disk so you can get back to this state quickly if you need to.  This works but is a lot of effort, takes time, and you might forget a step which makes even following written instructions less repeatable, and therefore less reliable, than if you just had the computer do it for you.  Enter Vagrant.  With a simple command, Vagrant can create and provision one or more virtual machines in a fraction of the time they would take to set up by hand and it will produce the same results everytime.  When you run Vagrant commands, they use a configuration file that contains how you want the virtual machines built.  This file is always named Vagrantfile and Vagrant looks for it in the current directory (it will search parent directories until it finds one if there is no such file in the current directory).  Vagrantfile is text file who's format is actually snippets of code in the Ruby programming language so it isn't as easy to read as Ansible's YAML playbooks but you don't need to know how to program in Ruby to write a Vagrantfile, just follow the examples in Vagrant's documentation.  After Vagrant has selected all the virtual hardware it copies an image of a disk with the operating system already installed and configured and then it boots the virtual machine.  In order to be reusable as the starting point for any system, the disk image has a minimalist installation of the operating system. After the virutal machine is booted, Vagrant can optionally run a configuration management system, such as Ansible, to turn the virtual machine into a webserver, a database, or whatever you need it to be.  When you are done with your Virtual machine, a single command will delete it as if it was never there so you can get your disk space bace.  This lab will focus on using Vagrant but there is still the question of where the minimalist disk images, called "base boxes" in Vagrant's terminology, come from.
- *[Packer](https://www.packer.io/)*
    Packer is a free tool for creating disk images for a variety of different virtual platforms. Both locally hosted platforms and cloud platforms are supported.  Packer's configuration file is a text file using the JSON format.  The configuration file specifics which platforms to build for and the steps needed to complete and automated install of the operating systems.  Once it is finished building a virtual machine, its post-processors shutdown the VM and repackage the disk image created for the specific platform.  In our case, packer leaves us with a Vagrant base box file which can be installed into Vagrant's box cache and references in the Vagrantfile for one or more VMs.

Now that the introductions are out of the way, let's learn how to use these tools.

## Lab: Creating VirtualBox virtual machines with Vagrant
1. As mentioned above, Vagrant will look for its configuration file, ```Vagrantfile```, in the current directory so let's start by changing our location and making sure it's there:

    ```cd ~/demo/networkplus && ls```

The ```Vagrantfile``` file is created by the ```setup``` script so, if you don't see a ```Vagrantfile``` file in this directory, you should re-run ```cd ~/demo && ./setup networkplus```.
1. You can open the ```Vagrantfile``` to see which virtual machines are defined and how, but for our purposes, we can get the list of machines and their current status with:

    ```vagrant status```

    Virtual machines in the "not created" state do not yet exist in VirtualBox.  Let's create one of them now.
1. Use the ```vagrant up``` command to start one or more virtual machines.  If the machine is in the "poweroff" state, Vagrant will start it.  If the machine is in the "not created" state, Vagrant will first create the virtual machine, boot it, and run the provisioning scripts (if there are any).  Let's create the debian1 virtual machine now.

    ```vagrant up debian1```

    It takes a couple minutes to copy the disk, boot the VM, and run the provisioning scripts, but you should be left with a VM you can log into using the username "user" and the password "password".  Back on the host, if you run ```vagrant status``` again, you will see the status of the virtual machine is now "running".
1. You can also shutdown the virtual machine from the command line with ```vagrant halt```.  Let's do that now:

    ```vagrant halt debian1```

    The virtual machine shuts down but is not deleted.  Running ```vagrant status``` again shows the virtual machine is in the "poweroff" state.
1. By default, Vagrant only runs provisioning when the virtual machines are created.  If you change the provisioning scripts, you can re-run them on virtual machines that have already been created by adding the ```--provision``` option to ```vagrant up```.  Let's restart the debian1 virtual machine and re-run the Ansible provisioning script now (although it shouldn't need to change anything since it hasn't changed since the first time it ran).

    ```vagrant up --provision debian1```

    Note, you can also use ```--no-provision``` if you want Vagrant to create a virtual machine without running the default provisioning.
1. Finally, when we no longer need a virtual machine and would like to reclaim the disk space, we can delete the machine entirely with ```vagrant destroy```.  Don't worry, you can always recreat it again with ```vagrant up```, it will just take a couple minutes more as it has to copy the disk image again.  Let's destroy our virtual machine now.

    ```vagrant destroy debian1```

    Vagrant will ask you to confirm that you really want to destroy the virtual machine which is a little silly since ```vagrant up``` will recreate it.  If you find this prompt annoying, you can use ```vagrant destroy -f debian1``` instead to force the destroy operation.

In the steps above, we specified which virtual machine we were working with.  If you leave off the name of the virtual machine, Vagrant will perform the operation on all virtual machines defiend in the Vagrantfile file unless those machines have the "autostart: false" attribute in their definition.  We will **not** be using Vagrant to start and stop our virtual machines but we do need to make sure they all exist before we can add them to GNS3 so create all of them now and then shut them down with:

    ```vagrant up && vagrant halt```

With the virtual machines created, we are now ready to learn how to add them to our GNS3 models.

## Lab: Adding VirtualBox VMs to GNS3 network models

There are a couple of important caveats to keep in mind when using virtual machines in GNS3:

- **You can only have one of each virtual machine in any network model**

    GNS3 can connect a virtual machine to a network model but there is still only one instance of the virtual machine within VirtualBox.  Unlike the built-in switch devices where you can drag as many as you need into your network model, the virtual machines can only appear once.
- **You must start the virtual machines from within GNS3**

    Although you just learned you can start virtual machine using Vagrant, when using a virtual machine within a GNS3 model, you must start it from within GNS3 itself using the green, right pointing triangle icon.  This is because, in addition to starting the VMs, GNS3 also needs to manipulate their virtual network interfaces and connect them to the virtual networks in the model.

With those considerations in mind, let's add our virtual machines to GNS3.

1. With the VMs shutdown, start GNS3 and, from the ```GNS3``` menu, select ```Preferences``` to open the Preferences dialog.
1. Repeat the following steps for each virtual machine you want to use in GNS3 (don't add the GNS3 VM though):
    2. Select ```VirtualBox VMs``` on the left side of the Preferences dialog and then click the ```New``` button at the bottom.
    2. Select ```Run this VirtualBox VM on my local computer``` in the New VirtualBox VM template dialog and click the ```Next``` button.
    2. Select debian1 from the pre-populated ```VM List``` dropdown and click ```finish```.
    Depending on which machinces you have created in VirtualBox, the result might look like this:

    ![Preferences - VirtualBox VM templates](PreferencesVirtualBoxVMsTemplates.png)

1. Click ```OK``` to close the Preferences dialog

The virtual machines are now ready for use and should appear in the End Devices and All Devices docks on the left side of GNS3.
