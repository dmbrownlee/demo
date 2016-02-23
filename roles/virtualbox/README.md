virtualbox
==========

Test if the /usr/local/bin/VBoxManage exists and fail the role if it doesn't
with a message to install VirtualBox

Requirements
------------

VirtualBox needs to be installed for this role to succeed.

Role Variables
--------------

None

Dependencies
------------

None

Example Playbook
----------------

    - hosts: localhost
      roles:
         - role: virtualbox

License
-------

To be determined

Author Information
------------------

None
