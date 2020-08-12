This directory contains files for automating the installation of a minimal Linux system with a graphical desktop for use as a virtualization host for the virtual lab environments within the demo project.  If you already have Linux installed, you should not need anything here.  However, if you are having trouble with your installation, these are the kickstart and preseed files used to create the hosts on which the labs are tested.

# Overview
The basic steps are:
1. [Create the installion media](https://github.com/dmbrownlee/demo/blob/master/kvmhost/README.md#create-the-installation-media)
2. [Install the host using distribution specific automation](https://github.com/dmbrownlee/demo/blob/master/kvmhost/README.md#install-the-host-using-distribution-specific-automation)

## Create the installation media
There are plenty of better places to find information on how to do this so I'm keeping this short and only addressing using the dd command to write the ISO image to a file.
1. Download the ISO image you want to install:
    - [CentOS 8.2 boot ISO](http://distro.ibiblio.org/centos/8.2.2004/isos/x86_64/CentOS-8.2.2004-x86_64-boot.iso)
    - [Debian 10.5.0 netinst ISO](https://cdimage.debian.org/mirror/cdimage/archive/10.5.0/amd64/iso-cd/debian-10.5.0-amd64-netinst.iso)
2. View the checksum for the ISO file you downloaded
    - [CentOS 8.2 CHECKSUM](http://distro.ibiblio.org/centos/8.2.2004/isos/x86_64/CHECKSUM)
    - [Debian SHA256SUMS](https://cdimage.debian.org/mirror/cdimage/archive/10.5.0/amd64/iso-cd/SHA256SUMS)
3. Calculate the checksum on the ISO file you downloaded and compare it to the checksum in step 2.
    > On Linux:  
    > ```sha256sum *.iso```  
    >
    > On Mac:  
    > ```shasum -a 256 *.iso```  

    Assuming your checksum matches, you have downloaded the ISO file successfully and you can now use dd to write it to a USB flash drive.  In order to do that, you will need to know the disk device of your USB flash drive.
4. Before inserting your flash drive, run the following command to see your existing disks:
    > On Linux:  
    > ```lsblk```  
    >
    > On Mac:  
    > ```diskutil list```  
5. Insert the USB flash drive and re-run the commands above and look for the disk that did not exist on the first run.  That is your USB flash drive.
6. Now that you know the name of the USB flash drive, you can use dd to write the ISO image to it.
    > On Linux:  
    > ```sudo dd if=*<downloaded ISO image>* of=*<flash drive device file>* bs=4m status=progress```  
    >
    > On Mac:  
    > ```sudo dd if=*<downloaded ISO image>* of=*<flash drive device file>* bs=4M &```
The network installing ISO images are fairly small so the dd command should not take long.

## Install the host using distribution specific automation
**NOTE: The CentOS kickstart files and Debian preseed files shown here do NOT automate disk partioning to allow for flexible installations (such as dual-booting with other operating systems).  You should, however, still know what you are doing and, if losing everything on your disk would be a problem for you, you should have good backups just in case you make a mistake or there is a bug in the files.  The other CentOS kickstart files in this directory WILL remove any current drive contents so don't use them unless you know what you're doing.**

### CentOS
Boot from the installation media, use the cursor keys to highlight the menu option to install CentOS, and press 'e' __instead of pressing return__ so you can edit the menu option (the keys to press are displayed at the bottom of the screen in case you forget).  Use the cursor keys to go down to the line beginning with "linux" and use Ctrl-e to jump to the end of that line.  Once there, add the following to the end of the line:
```
inst.ks=https://raw.githubusercontent.com/dmbrownlee/demo/master/host_install/CentOS/ks.cfg
```
Then press Ctrl-x (as displayed at the bottom of the screen) to begin the installation.

The ks.cfg kickstart file is mostly automated but you will have to follow the text screen prompts to select the disk you want to install on.  If you are already familiar with how Linux names disks and know your system disk is sda, vda, or nvme0n1, you can use the corresponding kickstart file instead of the non-specific ks.cfg file to skip the disk sellection and have a fully automated install

Once the install completes, you will have an administrative user named "user".  The password for both of this account is "password" and you will be forced to change them to something more secure on first login.

### Debian
Boot from the installation media, use the cursor keys to highlight the "Advanced options..." menu option and press enter.  Next, select the "Automated install.." menu option and press enter.  The installation will begin.  When prompted for the location of the preseed file, use this URL:
```
https://raw.githubusercontent.com/dmbrownlee/demo/master/host_install/Debian/preseed.cfg
```
The Debian preseed file is mostly automated but you will have to follow the text screen prompts to select the disk you want to install on.  You may also need to write to the EFI partition.

Once the install completes, you will have an administrative user named "user".  The password for both of this account is "password" and you will be forced to change them to something more secure on first login.
