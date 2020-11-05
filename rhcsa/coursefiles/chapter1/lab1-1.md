# lab1-1: Installing CentOS

## OBJECTIVE

In this lab, you will practice installing CentOS manually.  You will not need to know how to install the operating system for the exam but you do need to know how to install it if you are planning to run it in the real world (at least until you have your automated PXE installs working on your network :grin:).

## SETUP

No special setup is needed for this lab.

## STEPS

In this lab, we will us Vagrant to spin up a virtual machine named ```installhost``` and install CentOS manually using the ```boot``` ISO image.  The ```boot``` ISO image is very small because it does not contain the softare needed to install the system.  Instead, it contains just the network software and the installer.  This makes downloading the ```boot``` ISO image much faster than downloading the full ```dvd1``` image and, even though you will still need to download the packages you need during installation, you are only downloading the packages you've chosen, not the entire library of packages available.  On the other hand, if install frequently, semi-regularly install lots of packages, or don't trust your Internet connection to be up the next time you need to install, it might be better to suffer the longer download of the ```dvd1``` image up front for slightly faster installs that do not rely on the Network being available.  There is also a ```minimal``` iso image that fills the middle ground in that, so long as you only need the packages for a minimal installation, it contains just what you need to install without a network connection.

> **Important:** Since we are using the ```boot``` image, you will need to enable your network adapters in the installer before you can pick the software you want to install. Other than that, the installations should work as describe in the study guide.

1. For you convenience, you can use Vagrant to spin up a virtual machine with an empty 20GB drive and and the ```boot``` media already inserted.  Of course, you can create the virtual machine manually if you would like to play with specific VirtualBox VM settings but the focus of this lab is on OS installation.
    <code>cd ~/demo/rhcsa && vagrant up installhost</code>
    This will create the virtual machine and boot the installation media.
    > **Note:** Vagrant is used for provisioning machines and expect to be able to SSH into the virtual machine as the user "vagrant" in order to perform custom configuration.  In our case, we are only using Vagrant as a convenient way to create the virtual machine.  The ```vagrant up installhost``` command will eventually fail when it gives up trying to connect via SSH.  This error can safely be ignored.
1. Install CentOS.  We suggest you try following the study guide's example the first time.
1. When you have completed the installation successfully, you can shutdown and remove the virtual machine completely with:
    <code>cd ~/demo/rhcsa && vagrant destroy -f installhost</code>

You can repeat the steps above as many times as you like.  Here are some suggestions for exploring installs:

- Configure a user with a weak password like "password".
- Do not set a password for the root user.
- Try customizing the disk partitions.
- Try customizing the packages that are installed.
- Try installing support for other languages and search the Internet for how to use them.
- If you find the perfect configuration for you, you might try saving the ```/root/anaconda-ks.cfg``` file for later :grin:.
