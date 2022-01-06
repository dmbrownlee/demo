# The Ansible directory for localhost configuration
The `~/demo/setup` script is a shell script that does just enough on your localhost to allow you to run an Ansible playbook, the `site.yml` file in this directory, which completes the rest of the setup on the local machine.

# Adding a new course
If you want to add a new course, the `update-content.yml` can help get you started by generating a schedule template, assignment pages, and "under construction" labs which you can edit later.  The advantage of using the `update-content.yml` playbook to generate all the stub content is it ensures the links between content pages are correct. It only creates docs that are missing so you can run it multiple times without worrying it will overwrite the lab content you have already written.

## Example: Adding a course for ICND1
Here are the steps if you wanted to start a new study group for ICND1:
```
cp ~/demo/ansible/roles/coursematerials/vars/{template,icnd1}.yml
vim ~/demo/ansible/roles/coursematerials/vars/icnd1.yml  # <-- bulk of the work is here as you have to specify were to find the resources
cd ~/demo/ansible
ansible-playbook -e course=icnd1 update-content.yml
```
> If you blindly pasted the line above into zsh on Mac and got an error from the comment on line 2, use `setopt INTERACTIVE_COMMENTS` to enable interactive comments in zsh.

The above lines will create the `~/demo/courses/icnd1/labs` directory and the stub filess for content there.  Any lab titles in the `vars/icnd1` file will create empty labe which you can cutomize.  Don't for get to check your new files into the relase branch if you want your links to work.  You could also just run the last line with course set to "template" instead of "icnd1" to get an idea what this does before editing your vars file.
