# lab1-3: Installing Rocky Linux

## OBJECTIVE

In this lab, you will practice installing Rocky Linux manually.  You will not need to know how to install the operating system for the exam but you do need to know how to install it if you are planning to run it in the real world (at least until you have your automated PXE installs working on your network :grin:).

## SETUP

No special setup is needed for this lab.

## BACKGROUND

In this lab, we will use Vagrant to spin up a virtual machine named ```installhost``` and install Rocky Linux manually using ```Rocky-8.5-x86_64-dvd1.iso```.

> **Important:** The book describes installing CentOS.  The direction of development of CentOS changed at the end of 2021 and the original CentOS developer left RedHat and started Rocky Linux as a replacement for CentOS.  Other than the name change, the installations should work as describe in the study guide.  You can find a download link for the Rocky Linux ISO image at [```https://rockylinux.org/download/```](https://rockylinux.org/download/).

For you convenience, you can use Vagrant to spin up a virtual machine with an empty 20GB drive and the ISO image already inserted in the virtual optical drive.  Of course, you can create the virtual machine manually if you would like to try specific virtual machine settings but the focus of this lab is on OS installation. Use ```vagrant up installhost``` to create the virtual machine and boot from the installation media.

## STEPS

1. Run ```vagrant up installhost``` and install Rocky Linux.  Follow the study guide's example the first time.

  > Note: Vagrant is used for provisioning machines and expect to be able to SSH into the virtual machine as the user "vagrant" in order to perform custom configuration.  In our case, we are only using Vagrant as a convenient way to create the virtual machine.  The ```vagrant up installhost``` command will eventually fail when it gives up trying to connect via SSH.  This error can safely be ignored.

  > Note: The mouse pointer is painfully slow in VirtualBox unless you have installed the VirtualBox Guest Additions.  The Guest Additions have been installed in the Vagrant base box we use for our other virtual machines but Guest Additions are not included in Rocky Linux installation media so the mouse pointer will be slow.

1. When you have completed the installation successfully, you can shutdown and remove the virtual machine completely with:

  ```
  vagrant destroy -f installhost
  rm -rf ~/VirtualBox\ VMs/installhost
  ```

  The second command removing the virtual machine's directory shouldn't be necessary but I find it often is.

1. Repeat the steps above as many times as you like while choosing different installation options.  Here are some suggestions for exploring installs:

  - Configure a user with a weak password like "password".
  - Do not set a password for the root user.
  - Try customizing the disk partitions.
  - Try customizing the packages that are installed.
  - Try installing support for other languages and search the Internet for how to use them.
  - If you find the perfect configuration for you, you might try saving the ```/root/anaconda-ks.cfg``` file for later :grin:.

## CONFIRMATION

You will know you have completed this lab successfully when the following are true:

  1. You are comfortable installing Rocky Linux from installation media
