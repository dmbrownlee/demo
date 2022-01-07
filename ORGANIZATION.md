# Project Organization
This document describes where to find content within the demo project in case you want to make changes/additions and is organized by task.  It doesn't list every file and directory.  Rather, it focuses on the important parts for a given task and assumes you can find the rest.  We're using Ansible for configuration management so knowledge of Ansible and Ansible's typical [role directory structure](https://docs.ansible.com/ansible/latest/user_guide/playbooks_reuse_roles.html#role-directory-structure) will be necessary for some tasks but is not covered here.

## I want to use Linux as the host operating system and would like a clean Linux installation that will work with the files here.
```
./host_install
```
The `host_install` directory contains RedHat kickstart and Debian preseed files you can use to automate your Linux installation so it is in a "known good" state that will work with this project.
> Note: We are mostly running study groups on MacOS laptops so these files are seldom used now and likely out of date.  For MacOS, a clean install of the OS via Internet Recovery is the assumed starting point.
> Note: We are migrating away from CentOS and to Rocky so, if the kickstart files are ever updated, they will be updated for the most recent version of Rocky.  More likely, they will be dropped entirely an only Debian will be supported (if any). These kickstart/preseed files were intended as a convenience for keeping a classroom full of Linux machines consistent.  They are entirely optional for the individual learner doing self-study and a clean install of Rocky/Debian should work fine.

## I want to make changes to how the host machine is configured.
```
./README.md
./setup
./ansible/
./ansible/site.yml
./ansible/roles/
```
The `./README.md` file documents how to configure your local machine to host the demo projects virtual machines.  It starts by running the `./setup` shell script which ensure there is just enough git and Ansible are installed before cloning this project into the user's home directory and running the `./ansible/site.yml` playbook which does the majority of the software installation and configuration.  The Ansible roles applied to the localhost in the `./ansible/site.yml` playbook can be found under the `./ansible/roles/` directory.

## I want to create a new course for a different study group
```
./courses/<course>/labs/
./ansible/README.md
./ansible/update_content.yml
./ansible/roles/coursematerial/vars/template.yml
```
Lab content for each course lives under `./courses/<course>/labs/`.  The `./ansible/update_content.yml` playbook can create a welcome page, an orientation page, a schedule template, and ssignment pages and empty lab pages which have a consistent look and no broken links (once merged with the "release" branch) in under a minute.  However, you first need to first create `./ansible/roles/coursematerial/vars/<course>.yml` to supply all the details of the course and course resources.  You can copy `./ansible/roles/coursematerial/vars/template.yml` to use as a starting point and instructions for running the playbook are in the `./ansible/README.md` file.
> Note, the Network+ course directory currently lives in `./demo/networkplus`.  This will be migrated to the new location under `./demo/courses` when it can be done without disrupting the current study group.

## I want my study group to have a consistent set of VirtualBox VMs to use for their labs
```
./courses/<course>/VMs/
./courses/<course>/VMs/Vagrantfile
./courses/<course>/VMs/ansible/
./courses/<course>/VMs/ansible/site.yml
./courses/<course>/VMs/ansible/roles/
```
We use [Vagrant](https://www.vagrantup.com/docs) to quickly spin up and destroy custom VirtualBox VMs as needed.  Most `vagrant` commands need to be run while you are in `./courses/<course>/VMs`, the directory containing `Vagrantfile`, the file which describes the number and types of VMs to build for the course.  After Vagrant creates the VMs from one or more cloned disk images (known as Vagrant "boxes"), it can customize each VMs separately using scripts or configuration management software.  Again, we use Ansible to minimize the number of technologies we need to support.  The `./courses/<course>/VMs/ansible/site.yml` playbook is only used by Vagrant when provisioning the VirtualBox VMs and the roles and other Ansible files used in VM provisioning are under `./courses/<course>/VMs/ansible/`.
> Currently, our Vagrantfiles are created dynamically by the `./setup` script when you pass it the name of the course as the first argument.  While this makes it quick to generate a new Vagrantfile when a new OS version is released, it has some drawbacks as well and we will likely be moving away from generating these files dynamically and just checking the static files into source control soon. Until then, the template used to create this file is for each course is `./ansible/roles/labenv_<course>/templates/Vagrantfile.j2`.

## I want more of the same type of VMs
```
./courses/<course>/VMs/Vagrantfile
```
Just add what you need to the [`Vagrantfile`](https://www.vagrantup.com/docs/vagrantfile).  However, keep in mind that virtual machines are not containers and can consume a lot of CPU cores and RAM when in use, and disk space even when not in use.  Consider using containers rather than virtual machines whenever it makes sense.  Also see the note in the task above.

## I want to create different kinds of VMs
```
./courses/<course>/VMs/Vagrantfile
```
We build our own custom Vagrant box files.  However, there are also many box files already available on [Vagrant Cloud](https://www.vagrantup.com/vagrant-cloud/boxes/catalog).  If you trust them.

## I want to build my own custom Vagrant box files for the VMs in my course
```
./packer/
```
We use a tool called [packer](https://www.packer.io/) to build our custom images and install them in Vagrant's cache.  When you run `./setup <course>` the playbook for setting up your course checks to see if you already have the Vagrant boxes you need (Run `vagrant box list` from any directory to see what's currently available). If the boxes do not already exist in Vagrant's cache, the `./setup` script will run packer to build them.  Packer uses a `.json` configuration file to build the Vagrant box file.  Since it need to do a complete installation of the OS, it also needs a file to automate the OS installation.  This is either a kickstart or preseed file for Rocky or Debian Linux respectively.  These files live in the `./packer/` directory and you can run packer manually with `packer build <filename>.json`.
> Packer has a new configuration file format, HCL2, and we still need to migrate our `.json` files to `.hcl` files.
> As with the Vagrantfiles above, the packer build files are currently generated dynamically by the `./setup` script but this is unnecessary and will likely change soon.
> pfsense is on the short list to get a custom packer build when time permits

## I want to use containers rather than VMs
```
./containers/README.md
./containers/
```
If you are planning to use GNS3 in your course, there is already a container engine in the GNS3 VM.  If you would like to run containers elsewhere, you need to provide the "elsewhere" in addition to the containers.  Like Vagrant box images, container images can be built and serve as a starting point for further customization once the container has been created from the container image.  The files and instructions for building and testing containers are stored under `./containers`. See `./containers/README.md` for more information.  Currently, the Network+ course uses exclusively Alpine Linux containers.  These containers are stripped down to essentials making them very small initially.  Alpine Linux is also very flexible in the types of serivces that can be added.  Before building your own container, see if you can use the existing Alpine Linux container for your needs.  Adding additional containers increase both the load times of network models and our support footprint.

## I'm using containers and would like to customize them for specific uses
```
./playbooks/projects/<model name>/site.yml
./playbooks/projects/<model name>/inv.yml
./playbooks/projects/<model name>/ansible.cfg
./playbooks/projects/<model name>/host_vars/
```
Again, Ansible comes to the rescue.  The Ansible configuration can be used to configure any machine, VM, or container so long as it is installed locally or can connect the node to be configured over the network.  Most system configuration also requires an account with admin level access to make changes.  Our Alpine Linux container image has `sshd` running and accepting inbound SSH connections and the "student" account in the container image has admin access via `sudo`.  If you specify `ANSIBLE_CONTROLLER=true` in the container environment when you create a container, the "student" user's home directory will also include a `configure_network` script.  This script will install git and Ansible and check out the `./playbooks/` directory from this GitHub repository.  Each project (GNS3 network model) has its own directory under `./playbooks/projects/` where you can create a `./playbooks/projects/<model name>/site.yml` playbook to configure the nodes in your network model.  You will also need an inventory file (typically `./playbooks/projects/<model name>/inv.yml`) and a `./playbooks/projects/<model name>/host_vars/` directory containing host specific variables for the nodes in your models.  To avoid duplication of effort, various Ansible roles are stored under `./playbooks/roles/` which can be used in any network model (see below).  In order to use these roles in your `./playbooks/projects/<model name>/site.yml` playbook, you will need an `./playbooks/projects/<model name>/ansible.cfg` file that includes this directory in the role path.  If you are new to Ansible, your best bet is to look at the existing models, copy what they do, and then tweak them to meet your needs.

## I want to create an Ansible role to deploy a service on any container in any network model
```
./playbooks/roles/
```
As mentioned above, the reusable Ansible roles should be stored under `./playbooks/roles/`.  Currently, the roles here are primarily written to work on our Alpine Linux container image (e.g. they use runit to manage services rather than systemd), but there is no reason they could not be updated to support other containers or the VMs which also accept incoming SSH connections and have a "student" account with admin access.
> The Vagrant VMs also have a "vagrant" account with admin access which is the account Vagrant actually uses when provisioning.

## I have a miscellaneous utility script that others might find useful in developing this content
```
./utils
```
This is the place for helpful one-off scripts not directly involved in the configuration management of the host, VMs, containers or other aspects of the demo project.
> For example, the `./ansible/update_content.yml` should really live here instead and will likely be moved here in the future.
