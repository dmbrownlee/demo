# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.ssh.private_key_path= "../keys/vagrant"
  # Common to all VMs
  config.vm.box = "ubuntu-15.10-desktop-amd64"
  config.vm.boot_timeout = 60
  #config.vm.synced_folder ".", "/vagrant", disabled=true

  config.vm.provision :ansible do |ansible|
    ansible.playbook = "ansible/playbook.yml"
  end

  # PC on the first network
  config.vm.define "pc-192.168.200.100" do |node|
    node.vm.hostname = "pc-192-168-200-100"
    node.vm.network "private_network", ip: "192.168.200.100", virtualbox__null: true, auto_config: false
    node.vm.provider "virtualbox" do |vb|
      vb.name = "pc-192.168.200.100"
      vb.customize ["modifyvm", :id, "--nic2", "null"]
    end
  end

  # PC on the second network
  config.vm.define "pc-172.16.200.100" do |node|
    node.vm.hostname = "pc-172-16-200-100"
    node.vm.network "private_network", ip: "172.16.200.100", virtualbox__null: true, auto_config: false
    node.vm.provider "virtualbox" do |vb|
      vb.name = "pc-172.16.200.100"
      vb.customize ["modifyvm", :id, "--nic2", "null"]
    end
  end

  # Webserver/CA server on the first network
  config.vm.define "pc-192.168.200.101" do |node|
    node.vm.hostname = "pc-192-168-200-101"
    node.vm.box = "ubuntu-15.10-server-amd64"
    node.vm.network "private_network", ip: "192.168.200.101", virtualbox__null: true, auto_config: false
    node.vm.provider "virtualbox" do |vb|
      vb.name = "pc-192.168.200.101"
      vb.customize ["modifyvm", :id, "--nic2", "null"]
    end
  end

  # "Internet" (Linux VM routing and doing NAT)
  config.vm.define "Internet" do |node|
    node.vm.hostname = "Internet"
    node.vm.box = "ubuntu-15.10-server-amd64"
    node.vm.network "private_network", ip: "1.1.1.254", virtualbox__null: true, auto_config: false
    node.vm.network "private_network", ip: "2.2.2.254", virtualbox__null: true, auto_config: false
    node.vm.provider "virtualbox" do |vb|
      vb.name = "Internet"
      vb.customize ["modifyvm", :id, "--nic2", "null"]
      vb.customize ["modifyvm", :id, "--nic3", "null"]
    end
  end

end
