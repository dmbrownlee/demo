This directory contains files for automating the installation of a minimal Linux system with a graphical desktop for use as the KVM host for the virtual machines in the labs.  If you already have Linux installed, you should not need anything here.  However, if you are having trouble with your installation, these are the kickstart and preseed files used to create the hosts on which the labs are tested.

# Overview
The basic steps are:
1. [Create the installion media](https://github.com/dmbrownlee/demo/blob/master/kvmhost/README.md#create-the-installation-media)
2. Install the host using distribution specific automation

Given the current focus on creating a lab environment for preparing for the RHCSA exam, the preferred and most tested platform is CentOS using kickstart files for automation.  However, suport for Debian (Buster) using preseed.cfg files has just started.

## Create the installation media
There are plenty of better places to find information on how to do this so I'm keeping this short and only addressing using the dd command on an existing Linux machine (Mac OS also has dd which works fine with the caveat that the options are just slightly different and identifying your USB flash drive is also different).  On Linux, open an terminal and run 'lsblk' to see your block devices.  Then insert your flash drive and run 'lsblk' again.  The difference in output will help you identify the device file (e.g. /dev/sdb) that references the flash drive.  Now download the network install ISO for the Linux distro you're using for the host platform.  Once downloaded, you can create the bootable flash drive with:
```
sudo dd if=<downloaded ISO image> of=<flash drive device file> bs=4m status=progress
```
The network installing ISO images are fairly small so the dd command should not take long.

### CentOS specifics
If you have not installed Linux yet or would like to start with a clean installation, the CentOS directory contains kickstart files for installing CentOS on host machines with different drive types.  First, create a bootable flash drive with the lastest (currently 8.1) version of CentOS following the [instructions on the CentOS site](https://docs.centos.org/en-US/8-docs/standard-install/assembly_preparing-for-your-installation/#making-media_preparing-for-your-installation).  Make sure you download the ISO file ending in "-x86_64-dvd1.iso".  The "x86_64" designates the image as being for Intel compatible CPUs and the "dvd1" designates the image as the DVD image which contains the software package the kickstart files try to install.

### Debian specifics
TODO: (currently using the netinstall ISO of Debian Buster)

## Install the host using distribution specific automation
**WARNING: The CentOS kickstart files and Debian preseed files shown here do NOT automate disk partioning to allow for flexible installations (such as dual-booting with other operating systems).  You should, however, still know what you are doing and, if losing everything on your disk would be a problem for you, you should have good backups just in case you make a mistake or there is a bug in the files.  The other CentOS kickstart files in this directory WILL remove any current drive contents so don't use them unless you know what you're doing.**

### CentOS
Boot from the installation media, use the cursor keys to highlight the menu option to install CentOS, and press 'e' __instead of pressing return__ so you can edit the menu option (the keys to press are displayed at the bottom of the screen in case you forget).  Use the cursor keys to go down to the line beginning with "linux" and use Ctrl-e to jump to the end of that line.  Once there, add the following to the end of the line:
```
inst.ks=https://raw.githubusercontent.com/dmbrownlee/demo/master/kvmhost/CentOS/ks.cfg
```
Then press Ctrl-x (as displayed at the bottom of the screen) to begin the installation.

The ks.cfg kickstart file is mostly automated but you will have to follow the text screen prompts to select the disk you want to install on.  If you are already familiar with how Linux names disks and know your system disk is sda, vda, or nvme0n1, you can use the corresponding kickstart file instead of the non-specific ks.cfg file to skip the disk sellection and have a fully automated install

Once the install completes, you will have an administrative user, named "user", in addition to the root admin account.  The password for both of these accounts is "password" and you will be force to change them to something more secure on first login.  Do that for both accounts before continuing.

### Debian
TODO: (write instructions for using the preseed file)
