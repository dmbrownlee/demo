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
	# Enable private key login
	mkdir -m 700 ~vagrant/.ssh
	cat /media/sf_vagrant_data/vagrant.pub >> ~vagrant/.ssh/authorized_keys
	chown -R vagrant ~vagrant/.ssh
	chmod 600 ~vagrant/.ssh/authorized_keys 
