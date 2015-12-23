setup:
	# Install sshd
	apt-get update
	apt-get upgrade -y 
	apt-get install -y openssh-server
	# Add the vagrant user
	adduser vagrant --disabled-password --gecos ""
	usermod -a -G vboxsf vagrant
	echo 'vagrant ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
	visudo -c
	echo '[User]' > /var/lib/AccountsService/users/vagrant
	echo 'SystemAccount=true' >> /var/lib/AccountsService/users/vagrant
	# psuedo idempotent edit of user.conf
	sed -r -i -e '/^hidden-users=/{s/ vagrant//;s/$$/ vagrant/}' /etc/lightdm/users.conf
	# Enable private key login
	mkdir -m 700 ~vagrant/.ssh
	cat /media/sf_vagrant_data/vagrant.pub >> ~vagrant/.ssh/authorized_keys
	chown -R vagrant ~vagrant/.ssh
	chmod 600 ~vagrant/.ssh/authorized_keys
	# Vagrant still requires old-style "ethX" interface names
	sed -r -i -e 's/^GRUB_CMDLINE_LINUX=""$$/GRUB_CMDLINE_LINUX="net.ifnames=0 biosdevname=0"/'
	grub-mkconfig -o /boot/grub/grub.cfg
