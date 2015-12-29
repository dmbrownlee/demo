#!/bin/bash -eufx

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

export PATH=/usr/bin:/bin:/usr/sbin:/sbin

#=============================================================================
# Step 1: Install sshd
#=============================================================================
apt-get install -y openssh-server

#=============================================================================
# Step 2: Add the vagrant user
#=============================================================================
adduser vagrant --disabled-password --gecos ""
echo '[User]' > /var/lib/AccountsService/users/vagrant
echo 'SystemAccount=true' >> /var/lib/AccountsService/users/vagrant

#=============================================================================
# Step 3: Add the vagrant user to the vboxsf group
#=============================================================================
usermod -a -G vboxsf vagrant

#=============================================================================
# Step 4: Ensure the vagrant user can login via ssh without a password
#=============================================================================
mkdir -m 700 ~vagrant/.ssh
cat /media/sf_vagrant_data/vagrant/vagrant.pub >> ~vagrant/.ssh/authorized_keys
chown -R vagrant ~vagrant/.ssh
chmod 600 ~vagrant/.ssh/authorized_keys

#=============================================================================
# Step 4: Ensure the vagrant user can run commands as root without a password
#=============================================================================
echo 'vagrant ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/vagrant
chmod 440 /etc/sudoers.d/vagrant
visudo -c

#=============================================================================
# Step 5: Configure "ethX" interface names
#=============================================================================
sed -r -i -e 's/^GRUB_CMDLINE_LINUX=""$$/GRUB_CMDLINE_LINUX="net.ifnames=0 biosdevname=0"/' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

#============================================================
# Optional: These commands are NOT required for vagrant to
#           run but are common enough that we want to
#           include them in the basebox image rather than
#           letting a configuration tool like puppet or
#           ansible handle it after the VM has been created.
#============================================================
# psuedo idempotent edit of user.conf
sed -r -i -e '/^hidden-users=/{s/ vagrant//;s/$$/ vagrant/}' /etc/lightdm/users.conf
# install a better browser
apt-get install -y chromium-browser
