# lab1-4: Automated Installs Using Kickstart

## OBJECTIVE

In this lab, we will learn how we can automate installs using a Kickstart file accessible from the network.

## SETUP

No special setup is needed for this lab.

## BACKGROUND

The Red Hat install program is called Anaconda.  When you install Red Hat manually, you are presented with a number of configuration options such as how to partition the disks, what software to install, and what user account to create.  After you have made all your selections, you can begin the installation.  The installer will save all your choices in a Kickstart file in ```/root/anaconda-ks.cfg```.  If you make this file accessible over the network, you can give the URL to Anaconda on future installs and it will read your choices from that an install accordingly without any interaction on your part.

The ```/root/anaconda-ks.cfg``` file makes a good starting point for additional customization and you can find more information about the Kickstart file format in "[Appendix A. Kickstart script file format reference](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/performing_an_advanced_rhel_installation/kickstart-script-file-format-reference_installing-rhel-as-an-experienced-user)" of Red Hat's "Performing an advanced RHEL installation" guide.

> Tip: Kickstart files have a post install section where you can add addition commands to run as root after the system is installed.  It is recommend you do **not** use this for general system configuration.  The first reason is the post section is only run during installation so running the configuration commands again is not possible without reinstalling.  The second reason is typos in your Kickstart file can cause your automated installation to fail so, once you have the initial Kickstart file tested and working, you want to touch it as little as possible.  Instead, use the Kickstart file to configure a user account for provisioning and install an idempotent system configuration tool such as Ansible.  After that, you can update your configuration changes in your Ansible playbooks without having to risk breaking your initial installs.

## STEPS

In this lab, we will be performing and automated install of the ```installhost``` virtual machine using a Kickstart file hosted on GitHub.  If you still have an ```installhost``` virtual machine from the previous lab, you can use ```vagrant destroy -f installhost && rm -rf ~/VirtualBox\ VMs/installhost``` to remove it before starting this lab.

1. Use the following command to create the ```installhost``` virtual machine and begin the installation:

  ```cd ~/demo/rhcsa && vagrant up installhost```

1. Use the cursor up key to select "Install CentOS Linux 8" (**do not press enter**) and press ```e``` to edit this option as indicated in the text at the bottom of the screen.

1. Use the cursor keys to navigate to the end of the line beginning with ```linuxefi```
  > Tip: You can use ```Ctrl-e``` on this screen to jump to the end of the line

1. Use the delete/backspace key to erase the word ```quiet``` at the end of the line (we like to see the installer's output) and replace it with ```inst.ks=https://raw.githubusercontent.com/dmbrownlee/demo/master/rhcsa/labfiles/chapter1/ks.cfg```.  The prompts at the bottom of the screen tell you how to discard your changes if you make a mistake.

  > Note: The kickstart file is viewable at [https://github.com/dmbrownlee/demo/blob/master/rhcsa/labfiles/chapter1/ks.cfg](https://github.com/dmbrownlee/demo/blob/master/rhcsa/labfiles/chapter1/ks.cfg).  However, that URL takes you to the file in the GitHub web interface which includes all the HTML to render the GitHub menus, etc.  When specifying the Kickstart file's URL in the installer, you always want to use a URL pointing to the raw text of the Kickstart file.

1. Once you have added the Kickstart option to the ```linuxefi``` line, you can press ```Ctrl-x to begin the installation.
  > If the installer starts a manual install and prompts you to make installation choices, then you likely have a typo in the URL you entered and the installer has fallen back to doing a manual install because it could not download the Kickstart file.  In this case, destroy the virtual machine and start over.

## CONFIRMATION

You will know you have completed this lab successfully when the following are true:

  1. You have successfully performed an automated install on the ```installhost``` virtual machine.
