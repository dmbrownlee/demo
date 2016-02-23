sshpass
=======

Installs sshpass from source tarball.  Ansible needs this to run tasks that
use "become".

Requirements
------------

Assumes you can build C source code and have autoconf and make installed.

Role Variables
--------------

The following variables are set in defaults/main.yml:
sshpass_version    Defaults to 1.05
sshpass_url        The URL for the 1.05 tarball
sshpass_srcdir     The directory created by the unpacked tarball

Dependencies
------------

None

Example Playbook
----------------

    - hosts: localhost
      roles:
         - { role: sshpass, sshpass_version: 1.05 }

License
-------

To be determined

Author Information
------------------

None
