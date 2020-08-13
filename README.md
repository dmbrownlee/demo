# The "demo" project
This project makes it easy to setup virtual lab environments, on either a Linux or MacOSX host machine using Vagrant.  On Linux, KVM or VirtualBox is used as the virtualization platform (depending on course requirements) and VirtualBox is used on Mac.  CentOS, Debian, and Ubuntu are the Linux distributions we are currently using as virtualization hosts.  In addition to the platform specific virtualization software, the setup script also installs packer, packer configuration files, and Vagrant which are used to automate building the VMs used in the lab environments.

# Prerequisites
Your hardware should support virtualization. This means your CPU has hardware virtualization support and multiple cores and you have lots of disk space for machine images and RAM to run multiple VMs simultaneously.  Your host OS should also have python3, git and Ansible already installed (the setup script will install Ansible for you if you are on Mac).  You will also want development tools on Mac for building vagrant pluggins (Ansible will install the dev tools for you on Linux).  The easiest way to get development tools on Mac, including git, is to install XCode from the Apple App Store.  It is recommended you start with a clean install of the operating system on your host.  If you are reinstalling Linux for use as the host platform, there are files in the [host_install](https://github.com/dmbrownlee/demo/tree/master/host_install) directory you can optionally use to automate some or all of your host installation. See the README.md in that directory for details.

# Getting Started
## Overview
Before you can begin using the virtual lab environmets, there are three setup steps you need to complete first:

1. Install and configure the virtualization tools on the host (one time - documented here)
2. Configure the virtualization environment for a specific lab (one time)
3. Instantiate a new virtual lab network (you can setup and tear down as needed)

In the first step, Ansible installs the necessary software on the host as mentioned above. Since Vagrant base boxes can be used in multiple lab envinronments, the packer configs are installed during this step.  However, building the base boxes is a time consuming step, particularly if you have a slow network connection, and the base boxes can take up a lot of disk space. For these reasons, the first step only provides the packer config files for building various Vagrant base boxes.  The base boxes don't get created until the second step and only the base boxes for that particular lab environment are created.  The first step is described below.  See the README.md file in the directory for the course your installing for steps two and three.

## Step 1: Install and configure the virtualization tools on the host
Login to the host machine using an administrative user. If you are reading this README on GitHub, you first need to use git to clone this repository to your home directory. This setup will also need to download additional files from the Internet so make sure your host has a reliable Internet connection before proceeding (maybe ping 8.8.8.8 as a test).  Once you are sure your Internet connection works, clone this repository with:
```
cd ~ && git clone https://github.com/dmbrownlee/demo.git
```
This will create a copy of this project in your home directory.  Next, setup the virtualization environment with:
```
cd ~/demo && ./setup
```
When prompted for the "SUDO" password (prompt is "BECOME" on Mac hosts), use the password of the account you are using.  This step can take a few minutes depending on the speed of your Internet connection and your machine and which tasks still need to be completed.  Ansible playbooks (the setup script is just a wrapper around Ansible) are idempotent so, if you get interrupted, just run it again and it will pick up where it left off.  Ansible displays each step as it goes and skips over steps that have already been done or are not relevant your platform.

> NOTE: if your host platform is running macOS Catalina, you will see an error during the VirtualBox install which is ignored.  When the setup script finishes, you need to go into System Preferences > Security & Privacy and allow the Oracle kernel extensions to run.

Assuming the setup script completed without errors, step one is done.  **You need to reboot before proceeding with the README.md in your course's directory.**

For step two, follow one of these links:
- [CompTIA Network+](https://github.com/dmbrownlee/demo/tree/master/networkplus)
- [Red Hat RHCSA](https://github.com/dmbrownlee/demo/tree/master/rhcsa)
