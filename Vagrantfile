# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.ssh.private_key_path= "../keys/vagrant"
  # Common to all VMs
  config.vm.box = "ubuntu-16.04.1-desktop-amd64"
  config.vm.boot_timeout = 60
  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.synced_folder "data/", "/data"

  config.vm.provision :ansible do |ansible|
    # ansible.verbose = "v"
    ansible.playbook = "ansible/vagrant-vm-playbook.yml"
  end

  # First Ubuntu desktop
  config.vm.define "pc-192.168.200.100" do |node|
    node.vm.hostname = "pc-192-168-200-100"
    node.vm.network "private_network", ip: "192.168.200.100", virtualbox__null: true, auto_config: false
    node.vm.provider "virtualbox" do |vb|
      vb.name = "pc-192.168.200.100"
      vb.customize ["modifyvm", :id, "--cableconnected1", "on"]
      vb.customize ["modifyvm", :id, "--nic2", "hostonly", "--hostonlyadapter2", "vboxnet5"]
    end
  end

  # Second Ubuntu desktop
  config.vm.define "pc-192.168.200.101" do |node|
    node.vm.hostname = "pc-192-168-200-101"
    node.vm.network "private_network", ip: "192.168.200.101", virtualbox__null: true, auto_config: false
    node.vm.provider "virtualbox" do |vb|
      vb.name = "pc-192.168.200.101"
      vb.customize ["modifyvm", :id, "--cableconnected1", "on"]
      vb.customize ["modifyvm", :id, "--nic2", "hostonly", "--hostonlyadapter2", "vboxnet5"]
    end
  end

  # SecurityOnion
  config.vm.define "SecurityOnion" do |node|
    node.vm.hostname = "SecurityOnion"
    node.vm.box = "ubuntu-14.04.5-desktop-amd64"
    node.vm.network "private_network", ip: "192.168.200.253", virtualbox__null: true, auto_config: false
    node.vm.provider "virtualbox" do |vb|
      vb.name = "SecurityOnion"
      vb.memory = 2048
      vb.cpus = 2
      vb.customize ["modifyvm", :id, "--cableconnected1", "on"]
      vb.customize ["modifyvm", :id, "--nic2", "null"]
    end
  end
end
