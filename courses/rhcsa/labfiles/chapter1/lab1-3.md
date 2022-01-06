# lab1-3: Installing CentOS

## OBJECTIVE

In this lab, you will practice installing CentOS manually.  You will not need to know how to install the operating system for the exam but you do need to know how to install it if you are planning to run it in the real world (at least until you have your automated PXE installs working on your network :grin:).

## SETUP

No special setup is needed for this lab.

## BACKGROUND

In this lab, we will use Vagrant to spin up a virtual machine named ```installhost``` and install CentOS manually using ```CentOS-8.3.2011-x86_64-boot.iso```.  The ```boot``` ISO image is very small because it does not contain the softare needed to install the system.  Instead, it contains just the network software and the installer.  This makes downloading the ```boot``` ISO image much faster than downloading the full ```dvd1``` image and, even though you will still need to download the packages you need during installation, you are only downloading the packages you've chosen, not the entire library of packages available.  On the other hand, if install frequently, semi-regularly install lots of packages, or don't trust your Internet connection to be up the next time you need to install, it might be better to suffer the longer download of the ```dvd1``` image up front for slightly faster installs that do not rely on the Network being available.

> **Important:** The book describes installing using the ***DVD*** ISO image.  Our virtual machine is booting from the ***boot*** ISO image.  The DVD ISO contains all the software you need to perform an installation whereas the bootimage is smaller and needs to download the software you are installing from a repository on the network. Therefore, you will need to enable your network adapters in the installer before you can select the installation source (see next note). Other than that, the installations should work as describe in the study guide. Alternatively, you could download the DVD ISO and change the virtual machine's settings to boot from that image, but that will take longer.

> **Installation Source**: You can find a list of mirror sites hosting CentOS at [```http://isoredirect.centos.org/centos/8/isos/x86_64/```](http://isoredirect.centos.org/centos/8/isos/x86_64/).  Note, the URLs for all of these sites are taking you to the directory containing the ISO images for installation media.  When you select a repository as the installation source in the installer, the URL needs to point to the directory with the base OS.  This means changing ```isos``` in the URL to ```BaseOS``` and adding ```os``` to the end.  For example, if [```http://centos.s.uw.edu/centos/8.3.2011/isos/x86_64/```](http://centos.s.uw.edu/centos/8.3.2011/isos/x86_64/) is a mirror site on the list that is close to you, you would use [```http://centos.s.uw.edu/centos/8.3.2011/BaseOS/x86_64/os/```](http://centos.s.uw.edu/centos/8.3.2011/BaseOS/x86_64/os/) as the URL for the repository when selecting the installation source.  Also note you can use ```8``` instead of ```8.3.2011``` to ensure you get to the latest release of CentOS 8 series (just in case a newer version has been released).

For you convenience, you can use Vagrant to spin up a virtual machine with an empty 20GB drive and and the ```boot``` media already inserted.  Of course, you can create the virtual machine manually if you would like to try specific virtual machine settings but the focus of this lab is on OS installation. Use ```vagrant up installhost``` to create the virtual machine and boot from the installation media.

## STEPS

1. Run ```vagrant up installhost``` and install CentOS.  Follow the study guide's example the first time.

  > Note: Vagrant is used for provisioning machines and expect to be able to SSH into the virtual machine as the user "vagrant" in order to perform custom configuration.  In our case, we are only using Vagrant as a convenient way to create the virtual machine.  The ```vagrant up installhost``` command will eventually fail when it gives up trying to connect via SSH.  This error can safely be ignored.

  > Note: The mouse pointer is painfully slow in VirtualBox unless you have installed the VirtualBox Guest Additions.  The Guest Additions have been installed in the Vagrant base box we use for our other virtual machines but Guest Additions are not included in CentOS installation media so the mouse pointer will be slow.

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

  1. You are comfortable installing CentOS from installation media
