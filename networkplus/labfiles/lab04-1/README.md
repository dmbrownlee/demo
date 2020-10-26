# Finding information about your Ethernet interface in Linux
In this lab, we will take a look a how to find information about your Ethernet interface in Linux.

## Setup
For this lab, we will use the debian1 virtual host.  We will need to install some additional software on the Linux VM so we will need a network map that has the Linux VM conected to a switch and with the switch connected to the Nat device to get out to the Internet.  You can import the portable project in this directory as a starting point and then drag the debian1 VM over and connect it to the switch.
Login to the debian1 VM as user/password, open a terminal, and run ```sudo apt install -y ethtool net-tools``` to install the software we need.

## Lab: Creating VirtualBox virtual machines with Vagrant
