# The "demo" project
This project provides files for creating a virtual lab environment, on a Linux host machine, which can be used to prepare for the RHCSA exam.  It was desgined for a study group which was using Sander Van Vugt's RHCSA/RHCE cert guides and video series (see the Resources section below). In the past, the author provided zipped .ova files of CentOS 7 virtual machines for use with VirtualBox (I can no longer find this zip file and believe the author has discontinuted it).  This project loosly replicates those virtual machines using Linux's native KVM virtualization.

# Getting Started
The goal is to learn Linux on Linux.  CentOS is a freely available Red Hat Enterprise Linux (RHEL) clone and we use that for the operating system on the virtual machines as well as the host OS the virtual machines are running in.

## Host setup
### Already have a CentOS host?
If you already have CentOS 7 or later installed on your machine, that should work (although, as of this writing, I have moved on to CentOS 8.1 and don't tend to go backwards to test older releases).  You will need git and ansible installed to get started.  You can find instructions for installing ansible using pip elsewhere but I would recommend just using yum to install the ansible package from the EPEL repository.  Install the epel-release package to make packages in that repository available.

### Want to start fresh?
**WARNING: The kickstart files provided will install Linux and remove any current drive contents**  
If you have not installed Linux yet or would like to start with a clean installation, the ks directory contains kickstart files for installing CentOS 8 on host machines with different drive types.  First, create a bootable flash drive with the lastest (currently 8.1) version of CentOS following the [instructions on the CentOS site](https://docs.centos.org/en-US/8-docs/standard-install/assembly_preparing-for-your-installation/#making-media_preparing-for-your-installation).  Make sure you download the ISO file ending in "-x86_64-dvd1.iso".  The "x86_64" designates the image as being for Intel compatible CPUs and the "dvd1" designates the image as the DVD image which contains the software package the kickstart files try to install.

Once you have the installation media created, boot from it, use the cursor keys to highlight the menu option to install CentOS, and press 'e' __instead of pressing return__ so you can edit the menu option (the keys to press are displayed at the bottom of the screen in case you forget).  Use the cursor keys to go down to the line beginning with "linux" and use Ctrl-e to jump to the end of that line.  Once there, add the following to the end of the line:
```
inst.ks=https://raw.githubusercontent.com/dmbrownlee/demo/master/rhcx/ks/ks.cfg
```
Then press Ctrl-x (as displayed at the bottom of the screen) to begin the installation.

The ks.cfg kickstart file is mostly automated but you will have to follow the text screen prompts to select the disk you want to install on.  If you are already familiar with how Linux names disks and know your system disk is sda, vda, or nvme0n1, you can use the corresponding kickstart file instead of the non-specific ks.cfg file to skip the disk sellection and have a fully automated install

Once the install completes, you will have an administrative user, named "user", in addition to the root admin account.  The password for both of these accounts is "password" and you will be force to change them to something more secure on first login.  Do that for both accounts before continuing.

## Virtual Environment Setup
Once you have a suitable host machine, you can clone this project and use it to setup the virtual lab environment.  Login to the host machine using an administrative user (any account that can sudo, the "user" account if you used the kickstart files above).  This setup will need to clone this repository and download CentOS packages, the CentOS ISO image, and a couple of utilities from Hashicorp (vagrant, packer) from the Internet so make sure your host has a reliable Internet connection before proceeding (maybe ping 8.8.8.8 as a test).  Once you are sure your Internet connection works, clone this repository with:
```
cd && git clone https://github.com/dmbrownlee/demo.git
```
This will create a copy of this project in your home directory.  Next, we install the software for the lab environment.  To kick this off, do this:
```
cd ~/demo/rhcsa && ./setup
```
When prompted for the "BECOME" password, use the password of the admin account you are using ("BECOME" is Ansible's "sudo").  This step takes long time, possibly a few hours depending on the speed of your Internet connection and your machine, since, in addition to downloading Gigabytes of software, it also spins up two different CentOS virtual machines and copies their disk images to use as templates for quickly spinning up virtual machines later.  Ideally, the time spent setting this up saves lots of time down the road.

## Spinning up  the virtual machines
A utility called Vagrant will create the KVM virtual machines and run ansible to configure them.  Once created, the virtual machines can be started and stopped quickly.  Here are the commands:

### Create all the virtual machines
Use "--no-parallel" to ensure the "labipa" virtual machine is up and running before the others.  The labipa virtual maching acts as the LDAP, Kerberos, and DNS server for the "server1" and "server2" virtual machines.  You will want it running while you work with the other virtual machines but typically won't need to login or work with it directly (though you can).
```
vagrant up --no-parallel
```
### Halt the virtual machines
```
vagrant halt
```
### Start a virtual machine named "labipa"
This command will create and provision the virtual machine if it doesn't already exist.  Otherwise, it just restarts the existing, halted virtual machine without running the Ansible provisioning playbook (you can add "--provision" if you want to run the playbook again).
```
vagrant up labipa
```
### Destroy the "server2" virtual machine
This removes the virtual machine as if it never existed.  You can always bring it back with "vagrant up" and that is a good way to restart with a clean environment (you can add "-f" to force the destroy without a confirmation).
```
vagrant destroy server2
```
### Using the Virtual Machines
You can start the Virtual Machine Manager application to interact with the virtual machines.  There are labs in ~/demo/rhcs/labfile to give you some things to try.  This directory is also available, read-only, in each of the virtual machines as /labfiles.  The lab numbers are based on the corresponding chapter numbers from Sander Van Vugt's RHCSA 8 Cert Guide.  I would also recommend trying the "Task of the Day" challenges on [CertDepot](https://www.certdepot.net/) for practice.

# Happy Learning!

## Resources
- [Red Hat RHCSA 8 Cert Guide: EX200 (Certification Guide) 1st Edition](https://www.amazon.com/gp/product/0135938139 "This project updated to match this source material")
- [Red Hat RHCSA/RHCE 7 Cert Guide: Red Hat Enterprise Linux 7 (EX200 and EX300) (Certification Guide) 1st Edition](https://www.amazon.com/RHCSA-RHCE-Cert-Guide-Certification/dp/0789754053 "Older book is still useful for the older RHCE material")
- If you have an account, you can also find these books and their corresponding video series, as well as other material from the same author, on [O'Reilly](https://learning.oreilly.com/home/).
