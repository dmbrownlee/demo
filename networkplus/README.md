# The CompTIA Network+ virtual lab environment

# Prerequisites
Before running the setup for the CompTIA Network+ virtual lab environment, it is assumed you have already prepared the virtualization software on your host operating system using the setup script in the top level [demo](https://github.com/dmbrownlee/demo) directory.

# Getting Started
## Configure the virtualization environment for a specific lab (Network+)
In this step, you run the setup script for a specific lab environment. The setup script configures any virtual networks it will need and checks to see if you already have the necessary vagrant base boxes built. If you previously built and installed these base boxes for a different lab environment, this step will go quickly.  However, this step can take quite a while (a few hours) if the base boxes don't already exist as packer needs to build them from scratch. The last thing the lab setup does is install a platform specific Vagrantfile for your lab environment and then pre-create the VMs so they exist and can be used from within GNS3. **Note: If your host machine is a laptop, you should take steps to prevent the laptop from sleeping as these steps take a long time to complete and require the network connection to be active.  For example, if you are on a Macbook, you should run ```caffeinate -dsu``` in a separate terminal.**

> On either Linux or Mac:  
> ```cd ~/demo/networkplus && ./setup```  

**NOTE: Once the setup has completed successfully, you should reboot the host before attempting to use GNS3.

## Using GNS3
TODO: document using GNS3 and the labs

# Happy Learning!
