# The "demo" project
This project makes it easy to setup virtual lab environments, on either a Linux or MacOSX host machine using Vagrant.  On Linux, KVM or VirtualBox is used as the virtualization platform (depending on course requirements) and VirtualBox is used on Mac.  CentOS, Debian, and Ubuntu are the Linux distributions we are currently using as virtualization hosts.  In addition to the platform specific virtualization software, the setup script also installs packer, packer configuration files, and Vagrant which are used to automate building the VMs used in the lab environments.

# Prerequisites
Your hardware should support virtualization. This means your CPU has hardware virtualization support and multiple cores and you have lots of disk space for machine images and RAM to run multiple VMs simultaneously.  Your host OS should also have python3, git and Ansible already installed (the setup script will install Ansible for you if you are on Mac).  You will also want development tools on Mac for building vagrant pluggins (Ansible will install the dev tools for you on Linux).  The easiest way to get development tools on Mac, including git, is to install XCode from the Apple App Store.  It is recommended you start with a clean install of the operating system on your host.  If you are reinstalling Linux for use as the host platform, there are files in the [host_install](https://github.com/dmbrownlee/demo/tree/master/host_install) directory you can optionally use to automate some or all of your host installation. See the README.md in that directory for details.

# Getting Started
## Overview
To install the virtualization software and, optionally, configure the machines for s particular study group, you just need to run a ```setup``` script.  The ```setup``` script is a small shell script that runs an Ansible playbook.  Ansible installs the necessary software on the host and updates the configuration. Vagrant base boxes are built once and used as a starting point for the VMs which speeds up creation of multiple VMs using the same operating system.  However, building the base boxes is a time consuming step, particularly if you have a slow network connection, and the base boxes can take up a lot of disk space. For these reasons, only the bases boxes for your specific study group are built.  If you run the ```setup``` script for another study group, it may need to build additional base boxes if it needs ones that don't already exist.

## Setup
Login to the host machine using an administrative user. If you are reading this README on GitHub, you first need to use git to clone this repository to your home directory. The ```setup``` script will also need to download additional files from the Internet so make sure your host has a reliable Internet connection before proceeding (maybe ```ping 8.8.8.8``` as a test).  Once you are sure your Internet connection works, clone this repository with:
```
cd ~ && git clone https://github.com/dmbrownlee/demo.git
```
This will create a copy of this project in your home directory.  Next, you run the ```setup``` script in the ```~/demo``` directory.  If you just want the virtualization software without configuring the VMs for a particular study group, you can run ```setup``` without arguments.  If you would also like to setup the virtual lab environment for a specific study group at the same time, pass the name of the study group (same as its directory) as the first argument.  For example, to setup everything for the Network+ study group, use:
```
cd ~/demo && ./setup networkplus
```
> NOTE: Since the ```setup``` script is an Ansible playbook, and playbooks are idempotent, you can run the ```setup``` script multiple times to setup the VMs for other study groups as well (currently, just ```rhcsa``` and ```rhce```)

> NOTE: If your host machine is a laptop, you should take steps to prevent the laptop from sleeping as these steps take a long time to complete and require the network connection to be active.  For example, if you are on a Macbook, you should run ```caffeinate -dsu``` in a separate terminal.

When prompted for the "SUDO" password (the prompt is "BECOME" on Mac hosts), use the password of the account you are using.  This step can take a few hours depending on the speed of your Internet connection, the speed of your machine, and which virtual machine builds and other tasks still need to be completed.  If the script get interrupted, just run it again and it will pick up where it left off.  Ansible displays each step as it goes and skips over steps that have already been done or are not relevant your platform.

> NOTE: if your host platform is running macOS Catalina, you will see an error during the VirtualBox install which will stop the script.  You need to go into ```System Preferences > Security & Privacy > General```, unlock the dialog using the lock icon on the bottom left, allow the Oracle kernel extensions to run, reboot the machine, and re-run the script.
