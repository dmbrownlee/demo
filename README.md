# The "demo" project
This project makes it easy to set up virtual lab environments on Mac using Homebrew.  In addition to VirtualBox, the ```setup``` script also installs packer, packer configuration files, and Vagrant which are used to automate building the VMs used in the lab environments.

# Prerequisites
Your hardware should support virtualization. This means your CPU has hardware virtualization support and multiple cores and you have lots of disk space for machine images and RAM to run multiple VMs simultaneously.  It is recommended you start with a clean install of macOS on your host.

# Getting Started
## Overview
To install the virtualization software, you just need to run a ```setup``` script.  The ```setup``` script is a small shell script that installs Homebrew, then uses Homebrew to install Ansible, and finally runs an Ansible playbook to handle the rest of the installation.  Ansible installs the necessary software on the host and updates the configuration.

## Setup
Make sure your power is plugged in and you have a working Internet connection.  Open a terminal and run this command from the command line to start the installation:
```
bash -c "$(curl -fsSL https://raw.githubusercontent.com/dmbrownlee/demo/master/setup)"
```
The script will prompt you for your password a few times as it needs elevated permissions to complete the installation  The first time through the script, the installation of VirtualBox will fail because, since Catalina, the installation of kernel extensions requires manual intervention.  Just follow the directions in the error message and reboot.
> NOTE: You need to go into ```System Preferences > Security & Privacy > General```, unlock the dialog using the lock icon on the bottom left, allow the Oracle kernel extensions to run, reboot the machine, and re-run the script.

After rebooting, open a terminal and run the setup script a second time with:
```
cd ~/demo && ./setup
```
This time, the Ansible playbook will finish the installation and the software common to all virtual labs will be installed.

Certain study groups require additional software.  For example, the Network+ study group also uses the GNS3 network simulator. If you would also like to set up the virtual lab environment for a specific study group, you do that by running the ```setup``` script again while passing the name of the study group's directory as the first argument.  For example, to setup everything for the Network+ study group, use:
```
cd ~/demo && ./setup networkplus
```
This will install the software and configuration files specific to that study group.

> NOTE: Although the software is installed, when you try to run it, you may receive multiple pop-ups from the operating system letting you know the applications are requesting additional access permissions.  This is a security feature of the operating system that requires the user to grant these permissions manually.
