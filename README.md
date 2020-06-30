# The "demo" project
This project makes it easy to setup virtual lab environments, on either a Linux or MacOSX host machine using Vagrant.  On Linux, KVM is used as the virtualization platform and VirtualBox is used on Mac.  CentOS, Debian, and Ubuntu are the Linux distributions we are currently using as virtualization hosts.  In addition to the platform specific virtualization software, the setup script also installs packer, packer configuration files (JSON files telling packer how to build Vagrant base boxes, disk images of previously installed systems, for the guest virtual machines) and Vagrant which are used to automate building and deploying the lab environments quickly and, more importantly, consistently.

# Prerequisites
Your hardware should support virtualization. This means your CPU has hardware virtualization support and multiple cores and you have lots of disk space for machine images and RAM to run multiple VMs simultaneously.  Your host OS should also have python3, git and Ansible already installed (the setup script will install Ansible for you if you are on Mac).  You will also want development tools on Mac for building vagrant pluggins (Ansible will install the dev tools for you on Linux).  The easiest way to get development tools on Mac, including git, is to install XCode from the Apple App Store.

# Getting Started
## Overview
Before you can begin using the virtual lab environmets, there are three setup steps you need to complete first:

1. Install and configure the virtualization tools on the host (one time)
2. Configure the virtualization environment for a specific lab (one time)
3. Instantiate a new virtual lab network (you can setup and tear down as needed)

In the first step, Ansible installes the necessary software on the host as mentioned above. Since Vagrant base boxes can be used in multiple lab envinronments, the packer configs are installed during this step.  However, since building the base boxes requires performing an automated Linux install and then saving a snapshot of the disk when it is finally finished, it can be a time consuming step, particularly if you are downloading large installation media and updating the image over a slow network connection. For this reason, we provide packer config files for building various Vagrant base boxes but don't actually create the base boxes until you run the setup script for a lab environment that uses them.

In the second step, you run the setup script for a specific lab environment. The configures any virtual networks it will need and checks to see if you already have the necessary vagrant base boxes. If you previously built and installed these base boxes for a different lab environment, this step will go quickly.  However, this step can take quite a while if the base boxes don't already exist as packer needs to build them from scratch. The last thing the lab setup does is install a platform specific Vagrantfile for your lab environment.

Once you have the Vagrantfile, Vagrant's configuration file, you can use the 'vagrant' command as described below to quickly setup and teardown the lab environment at will.

## Virtualization Host Setup
Login to the host machine using an administrative user. If you are reading this README on GitHub, you first need to use git to clone this repository to your home directory. This setup will also need to download Linux ISO images, updated packages, etc. from the Internet so make sure your host has a reliable Internet connection before proceeding (maybe ping 8.8.8.8 as a test).  Once you are sure your Internet connection works, clone this repository with:
```
cd ~ && git clone https://github.com/dmbrownlee/demo.git
```
This will create a copy of this project in your home directory.  Next, setup the virtualization environment with:
```
cd ~/demo && ./setup
```
When prompted for the "BECOME" password, use the password of the admin account you are using ("BECOME" is Ansible's "sudo").  This step can take a long time depending on the speed of your Internet connection and your machine and what needs to be done.  Ansible playbooks (the setup script is just a wrapper around Ansible) are idempotent so, if you get interrupted, just run it again and it will pick up where it left off.  Ansible displays each step as it goes and skips over steps that have already been done or are not relevant your platform.

## Virtual Lab Setup
This process should be the same, change into the lab's directory and run setup.  For example, the lab environment created for RHCSA study groups is in the "rhcsa" directory (see the README.md file there for more information).  To setup your machine to host this virtual lab environment, you would run:
```
cd ~/demo/rhcsa && ./setup
```
As previously mentioned, this would create the vagrant base boxes for the lab if they did not already exist.

## Using the virtual lab environment
A utility called Vagrant will create the KVM or VirtualBox virtual machines and run ansible to configure them.  Once created, the virtual machines can be started and stopped quickly.  Here is and overview of useful Vagrant commands.

### Create all the virtual machines
The "vagrant up" command will create all virtual machines described in the Vagrantfile simultaneously.  Use "--no-parallel" to create and start the virtual machines in the order they appear in Vagrantfile is order is important.  For example, in the rhcsa lab environment, you want to ensure the "labipa" virtual machine is up and running before the others (the labipa virtual maching acts as the LDAP, Kerberos, and DNS server for the "server1" and "server2" virtual machines).
```
vagrant up --no-parallel
```
### Halt the virtual machines
```
vagrant halt
```
### Start a virtual machine named "labipa"
This command will create and provision the virtual machine if it doesn't already exist.  Otherwise, it just restarts the existing, halted virtual machine without running the Ansible provisioning playbook (you can add "--provision" if you want to run the playbook again).
```
vagrant up labipa
```
### Destroy the "server2" virtual machine
This removes the virtual machine as if it never existed.  You can always bring it back with "vagrant up" and that is a good way to restart with a clean environment (you can add "-f" to force the destroy without a confirmation).
```
vagrant destroy server2
```
Additonal Vagrant documentation can be found on the [Vagrant web site](https://vagrantup.com).

# Happy Learning!
