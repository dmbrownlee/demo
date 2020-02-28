# Google Cloud Platform
This directory provides files for creating a virtual lab environment, on Google Cloud Platform (GCP), which can be used to learn Linux.  I'm still exploring whether or not GCP is suitable as a platform for preparing for the RHCSA exam but it is still useful for general Linux learning.In particular, the goal is to make this useful for our learners who have to work from Chromebooks and don't have the option of running KVM, VirtualBox, or other virtualization software locally.

# Getting Started
With the goal being to spin up virtual machines with nothing more than a browser (ChromeOS), we need to start with a Google (GMail) account and the ability to create virtual machines on GCP.

## Account setup
### Don't have a Google Account?
You will need to be logged into your Google (GMail) account.  If you don't have a Google account (or would like to create another for testing purposes), follow [Google's instructions](https://support.google.com/accounts/answer/27441?hl=en) to create one.

### Need GCP access?
In addition to a Google account, you will need the ability to create Google Compute Engine (GCE) virtual machines from the [GCP Console](https://console.cloud.google.com/).  If you are using a personal Google account, you can opt-in to the free trial which gives you up to a year or $300 credit to spend to take it for a test drive.  If instead, your Google account is provided by your orginization, you will need to talk to your administrator if you don't have console access.

## Virtual Environment Setup
If this is your first time using GCP and you're just kicking the tires, you can use the default project.  Otherwise, you may wish to create a project specifically for the lab environment.  Make sure you are in the project you plan to use before continuing.

Open a Cloud Shell Console by clicking the icon for it in the upper right corner of the [GCP Console](https://console.cloud.google.com/) (or try [https://ssh.cloud.google.com/cloudshell/editor](https://ssh.cloud.google.com/cloudshell/editor)).  This will spin up a minimal virtual machine runing Debian Linux and leave you in a shell which has cloud tools installed and you can use as a launchpad for spinning up your projects.  From the shell prompt, check out this GitHub repo using:
```
cd && git clone https://github.com/dmbrownlee/demo.git
```
This will create a copy of this project in your home directory.  Next, we install the software for the lab environment.  To kick this off, do this:
```
cd ~/demo/gcp/ansible && ./ansible-install.sh
```
This will install the Ansible configuration management utility.  Before running Ansible, you have the opportunity to change the defauts using your editor of choice.  For example:
```
nano ~/demo/gcp/ansible/roles/terraform-controller/defaults/main.yml
```
When you're happy with the defaults.yml file, save it and then run the playbook with:
```
cd ~/gcp/ansible && ansible-playbook playbook.yml
```
This with create the ~/terraform directory a with a Terraform config file for spinning up the lab environment in GCP.

## Spinning up the virtual machines
The following instructions describe how to spin up and tear down the lab environement in GCP.  This process created GCE virtual machines which may cause you to incur charges to be aware of what you are spending and remember to tear down your lab environment when you are done.

### Create a GCP service account and copy the service key
(... instructions for creating a GCP service account and saving the JSON key go here...)

### Create all the virtual machines
Use the following commands to spin up the lab environment:
```
cd ~/terraform &&
terraform plan &&
terraform apply
```
Type "yes" when prompted.

### Destroy the lab environment
When you are done with the lab environment, you can tear down the virtual machines so you don't incur any further charges with:
```
cd ~/terraform &&
terraform destroy
```
Type "yes" when prompted.

### Using the Virtual Machines
(... instructions to be written...)

# Happy Learning!
