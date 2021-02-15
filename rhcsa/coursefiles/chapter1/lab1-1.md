# lab1-1: Installing CentOS

## OBJECTIVE

In this lab, you will practice installing CentOS manually.  You will not need to know how to install the operating system for the exam but you do need to know how to install it if you are planning to run it in the real world (at least until you have your automated PXE installs working on your network :grin:).

## SETUP

No special setup is needed for this lab.

## BACKGROUND

In this lab, we will use Vagrant to spin up a virtual machine named ```installhost``` and install CentOS manually using ```CentOS-8.3.2011-x86_64-boot.iso```.  The ```boot``` ISO image is very small because it does not contain the softare needed to install the system.  Instead, it contains just the network software and the installer.  This makes downloading the ```boot``` ISO image much faster than downloading the full ```dvd1``` image and, even though you will still need to download the packages you need during installation, you are only downloading the packages you've chosen, not the entire library of packages available.  On the other hand, if install frequently, semi-regularly install lots of packages, or don't trust your Internet connection to be up the next time you need to install, it might be better to suffer the longer download of the ```dvd1``` image up front for slightly faster installs that do not rely on the Network being available.

> **Important:** Since we are using the ```boot``` image, you will need to enable your network adapters in the installer before you can pick the software you want to install. Other than that, the installations should work as describe in the study guide.

For you convenience, you can use Vagrant to spin up a virtual machine with an empty 20GB drive and and the ```boot``` media already inserted.  Of course, you can create the virtual machine manually if you would like to try specific virtual machine settings but the focus of this lab is on OS installation. Use ```vagrant up installhost``` to create the virtual machine and boot from the installation media.

## STEPS

1. Run ```vagrant up installhost``` and install CentOS.  Follow the study guide's example the first time.

  > Note: Vagrant is used for provisioning machines and expect to be able to SSH into the virtual machine as the user "vagrant" in order to perform custom configuration.  In our case, we are only using Vagrant as a convenient way to create the virtual machine.  The ```vagrant up installhost``` command will eventually fail when it gives up trying to connect via SSH.  This error can safely be ignored.

  > Note: The mouse pointer is painfully slow in VirtualBox unless you have installed the VirtualBox Guest Additions.  The Guest Additions have been installed in the Vagrant base box we use for our other virtual machines but Guest Additions are not included in CentOS installation media so the mouse pointer will be slow.

1. When you have completed the installation successfully, you can shutdown and remove the virtual machine completely with:

  ```
  vagrant destroy -f installhost
  ```

1. Repeat the steps above as many times as you like while choosing different installation options.  Here are some suggestions for exploring installs:

  - Configure a user with a weak password like "password".
  - Do not set a password for the root user.
  - Try customizing the disk partitions.
  - Try customizing the packages that are installed.
  - Try installing support for other languages and search the Internet for how to use them.
  - If you find the perfect configuration for you, you might try saving the ```/root/anaconda-ks.cfg``` file for later :grin:.

## CONFIRMATION

You will know you have completed this lab successfully when the following are true:

  1. You are comfortable installing CentOS from installation media
