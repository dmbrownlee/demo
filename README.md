# vagrantbox
A project for using vagrant with VirtualBox on Mac OS X

=== Pre-requisites
This simple project assumes you already have git and ansible installed on
Mac OS X.  If you downloaded this file using means other than git, try running
"git" at the terminal's bash prompt to see if it displays a version or if it
offers to install xcode (Apple includes git with xcode).  Install xcode if it
isn't installed already.

To install ansible, follow the instructions on their web site.  As of this
writting, installing ansible on Mac OS X is a matter of running these commands:

  $ sudo easy_install pip
  $ sudo pip install ansible

=== Bootstrapping the VirtualBox environment
The following commands use ansible to install VirtualBox, vagrant, and other
support utilities used for building vagrant baseboxes for use with your own
projects:

  $ cd setup
  $ ansible-playbook setup.yml

Building a base box
===================
After running the one time setup, building a base box for vagrant is almost as
easy.  Just do:

  $ cd ansible
  $ ansible-playbook playbook-<...>.yml

where playbook-<...>.yml is the playbook for the distro for which you want a
base box.  The ansible playbooks run in three steps, pausing between each while
you complete some steps manually.

Step 1:
Ansible creates a VirtualBox VM on the localhost with a name matching the ISO
file without the .iso extension.  It then inserts the distro's ISO file into
the VM's DVD drive and boots the VM beginning the OS install. Manually install
the OS as you would normally.  Keep in mind that Ansible needs to be able to
ssh to the VM as a known admin user in order to configure the machine in Step 2
so, in this step, create the admin user "demouser" and make sure OpenSSH server
is installed.  Depending on the distribution and configuration being done, you
may also need to install additional software for the configuration in Step 2 to
complete.  See "Step 1 distro Specific notes" below. The Ansible playbook pauses
after it starts the OS install. After you have completed the OS install with
the prerequistes for Step 2 and rebooted, press Ctrl-C to continue running the
playbook.

Step 2:
Ansible takes care of all the configuration of the VM including adding the 
necessary account and ssh keys for Vagrant support, configuring the network
interfaces to use the older ethX naming convention (also a Vagrant requirement),
updating all packages, installing VirtualBox Guest Additions for the current
kernel, etc.  Although Ansible takes care of everything, the playbook pauses at
the end of Step 2 to allow you to make any additional manual tweaks not already
in the playbook before creating the basebox image from this VM.  Press Ctrl-C
to begin the last step.

Step 3:
Ansible returns to the localhost where it shuts down the VM from the previous
steps and packages as a Vagrant basebox and then installs it for use on the
localhost.

Step 1 distro Specific notes
============================
The following is a list of additional software that should be installed during
Step 1, before continuing to Step 2, sorted by distro.

ubuntu-15.10-desktop-amd64
- openssh-server
- aptitude

ubuntu-15.10-server-amd64
- python

CentOS-7-x86_64-DVD-1511
- Make sure you chose "Default" as the Security Policy.
