# lab1-1: Learn to create a git repository
> Sorry, this lab has not be reviewed recently and may contain outdated material, spelling and grammar errors, and/or poor markdown formatting.

## OBJECTIVE

Get familiar with the Rocky installer as well as learn just enough about KVM virtual machines to give you a platform to test on.  In this lab, you will practice installing your own Rocky machine.  You will be using the Virtual Machine Manager app to configure a new virtual machine.

## SETUP

Before beginning the lab, you may want to skim Chapter 10 of the study guide and/or watch the videos in Chapter 11 of the video series on Safari Online for additional background on virtual machines.  You will also need to navigate to [https://rockylinux.org/download/](https://rockylinux.org/download/) and download the current .iso image you wish to install with (I recommend the "Everthing" iso image if you don't know why you would choose one of the others).

## STEPS

On the host machine:

  1. Open Virtual Machine Manager (Applications > System Tools > Virtual Machine Manager)
  1. Create a new virtual machine and ensure it has a CD-ROM drive
     1. File > New Virtual Machine
     1. Select "Local install media (ISO image or CDROM)" and click "Forward"
     1. Select "Use ISO image" and click "Browse..."
     1. Click "Browse Local"
     1. Navigate to the Downloads directory,
        select the Rocky .iso file you downloaded, and click "Open"
     1. Click "Forward". If prompted with a message about fixing permissions,
        click "Yes"
     1. Set Memory to 1024 and CPUs to 1 and click "Forward"
     1. Specify at least 10.0 GB for storage and click "Forward"
     1. Choose a name for the virtual machine and click "Finish"

The virtual machine will launch and boot from the virtual CDROM drive.  The window size is fine for the text display but may be too small for the GUI.  To fix this, wait until the GUI has started and then choose View > Resize to VM from the Virtual Machine Manager menus.  From there, you can install as you would on a real machine.  When the installation is complete and you click "Reboot", the ISO image will be ejected from the virtual CDROM drive automatically.

When you are ready to remove the virtual machine, turn it off and then right click on the virtual machine in Virtual Machine Manager's list of machines.  Choose "Delete" from the menu, keep "Delete associated storage files" selected, and click "Delete".
