# vagrantbox
A project for building vagrant base boxes for use with VirtualBox on Mac

=== Pre-requisites
This project assumes you already have git installed.  If you don't, just
open a terminal and type "git" and you will be prompted to install XCode
which includes git.

=== Installation
Use git to check out this project:

  $ git clone https://github.com/dbrownlee/vagrantbox.git

Then run setup as root from the vagrantbox directory:

  $ cd vagrantbox && sudo ./setup

The setup script will install pip which will install ansible which will
run the tasks in the ./ansible/setup-localhost.yml ansible playbook.  These
tasks include creating a key pair for the vagrant user to use in ~/keys,
installing packer if it doesn't exist already, installing vagrant if it
doesn't exist already, installing virtualBox if it doesn't exist already,
and building sshpass from source if it doesn't exist already.  You are now
ready to build vagrant base boxes for use with VirtualBox

Building a base box
===================
Almost all the work of building a base box is done by packer but, I wrap it
in an ansible playbook so the base box is installed on the local system
when it is done building.  Each supported distro has a .yml and .json file.
You can build and install the base box with:

  $ ansible-playbook <distro>.yml

The ansible playbook will build <distro>.box if it does not exist and
install it.  If you just want to build the <distro>.box file whether or not
it exists, you can run:

  $ packer build <distro>.json
