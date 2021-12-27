 # Testing the basebox role

> Note:</br>If the vagrant basebox already exists, the build will get skipped

1. Change to the ansible directory and run the test playbook
   ```
   cd ~/demo/ansible
   ansible-playbook -K roles/basebox/tests/site.yml
   ```
1. Use vagrant to spin up the VMs (or a particular VM)
   ```
   cd ~/demo/ansible/roles/basebox/tests
   vagrant up
   ```
1. Destroy them when you are done to free up the disk space
   ```
   vagrant destroy -f
   ```
