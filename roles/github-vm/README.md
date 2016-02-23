github-vm
=========

The github-vm role pulls the vm project from github

Requirements
------------

Requires git be installed.

Role Variables
--------------

install_dir:  Defaults to ~/vm in the user's home directory
vm_repo:      URL of the github repo containing the VM environment you're
              trying to bootstrap

Dependencies
------------

None

Example Playbook
----------------

    - hosts: localhost
      roles:
         - { role: github-vm, vm_repo: "https://github.com/dmbrownlee/vm.git" }

License
-------

To be determined

Author Information
------------------

None
