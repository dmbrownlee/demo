# demo
This project provides files for creating a virtual lab environment which can be used to prepare for the RHCSA/RHCE exams.  The ks directory contains kickstart files for installing CentOS 8 on host machines with different drive types.  The kickstart files clone this repository.  After logging in and choosing a new root password (default is "password"), change to ~/demo/rhcx and run "./setup".  This script will install vagrant and packer and build vagrant base boxes for KVM which will allow you to quickly spin up and tear down virtual machines you can use with the labs.

Note: There are still files for using CentOS 7 but I'll be removing these soon-ish.
