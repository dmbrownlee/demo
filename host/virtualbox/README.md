This directory contains files for automating the installation of VirtualBox, Vagrant, etc on a Mac for use as a host platform for the virtual lab environment.

Note: The Vagrantfile provided in each course currently only works with KVM virtualization on Linux.  I'm in the process of new lab environments specifically for VirtualBox and will provide a VirtualBox specific Vagrantfile for each of those as they become available.  For now, this is just useful for installing the virtualization platform on MacOS.

# Overview
The basic steps are:
1. Install XCode from the App Store
2. Run the setup script

## Install XCode from the App Store

XCode is used to provide a consistent development environment from the command line.  Specifically, it provides the git command for the first step but also provides the need build tools to compile vagrant plugins as needed.  A quick way to install it is to run:
```
git --version
```
If git is not already installed, you can follow the prompts to install XCode from the App Store.

## Run the setup script
The setup script will install everything else.  It is a small shell script that installs Ansible and then runs an Ansible playbook that does all the real configuration work.  However, before you can do this, you first need to get the files by cloning the git repo to your home directory on your local MacOS machine:
```
cd && git clone https://github.com/dmbrownlee/demo.git
```
This will create a copy of this project in a directory named "demo" in you home directory.  Now change to the directory with the VirtualBox setup script and run it:
```
cd ~/demo/host/virtualbox && ./setup
```
sudo will prompt you for your password as it needs to use pip to install Ansible.  When Ansible starts you will be prompted for the "BECOME" password.  This is the same password you use for sudo ("BECOME" is Ansible's "sudo").  Ansible will display what it is doing as it goes.
