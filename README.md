# security2
This project tries to automate configuring a MacBook Pro/Air with the 
software needed to complete the exercises in the security2 class.

=== Installation
I assume you used git to clone this project but, if you received it via
some other method, you will need to make sure you have git installed.  You
will also need permission to run commands as admin using sudo.

Run the following:

$ ./setup

The script will run sudo and prompt for your password to install Ansible.
Once ansible is installed, all remaining installation and configuration is
done from an Ansible playbook.
