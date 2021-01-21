# The "demo" project
This project makes it easy to set up virtual lab environments on Mac OSX or Debian Linux.  In addition to VirtualBox, the ```setup``` script also installs packer, packer configuration files, and Vagrant which are used to automate building the VMs used in the lab environments.

# Prerequisites
Your hardware should support virtualization. This means your CPU has hardware virtualization support and multiple cores and you have lots of disk space for machine images and RAM to run multiple VMs simultaneously.  It is recommended you start with a clean install of macOS on your host.

# Getting Started
## Overview
To install the virtualization software, you just need to run a ```setup``` script.  The ```setup``` script is a small shell script that installs Ansible and then runs an Ansible playbook to handle the rest of the installation.  On Mac OSX, the ```setup``` script also installs Homebrew to make the installation of Open Source software easier.

## Setup
Make sure your power cable is plugged in if you are on an laptop and you have a working Internet connection.  Open a terminal and run this command from the command line to start the installation:
```
bash -c "$(curl -fsSL https://raw.githubusercontent.com/dmbrownlee/demo/master/setup)"
```
The script will prompt you for your password a few times as it needs elevated permissions to complete the installation.
> NOTE: The first time through the script on Mac OSX, the installation of VirtualBox will fail because the installation of kernel extensions requires manual approval.  You need to go into ```System Preferences > Security & Privacy > General```, unlock the dialog using the lock icon on the bottom left, allow the Oracle kernel extensions to run, and reboot the machine.  After rebooting, open a terminal and run the setup script a second time with:
> ```
> cd ~/demo && ./setup
> ```
> This time, the Ansible playbook will finish the installation and the software common to all virtual labs will be installed.

## Using the virtual lab environment
The steps above install the virtualization software and utilities which can be used as is.  Specific study groups will require additional software and will provide additional setup instructions.

> NOTE: Although the software is installed, when you try to run it on Mac OSX, you may receive multiple pop-ups from the operating system letting you know the applications are requesting additional access permissions.  This is a security feature of the Mac OSX operating system that requires the user to grant these permissions manually.
