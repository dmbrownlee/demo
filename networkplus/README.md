# The CompTIA Network+ virtual lab environment

# Getting Started
> NOTE: This virtual lab environment is only tested on Mac OS X and Debian (Buster)

## Configure the virtualization environment for the Network+ study group
These instructions are for machines that already have the demo project installed.  If you have not installed the demo project yet, follow the instructions in the demo project's [```README.md```](https://github.com/dmbrownlee/demo/blob/release/README.md) first.

These instructions will install additional software (GNS3, Wireshark, etc.) and the Vagrantfile needed to build the VirtualBox VMs for the Network+ study group.

> On either Linux or Mac:  
> ```cd ~/demo && ./setup networkplus```  

Once the setup has completed successfully, you should reboot the host before attempting to use GNS3.

## Import the virtual lab network
Originally, labs were setup with their own networks.  In order to save you time, we are moving to a single, virtual lab network that you can use for all the labs.  Please follow the directions in this [README](https://github.com/dmbrownlee/demo/blob/release/networkplus/labfiles/README.md) to set it up.
