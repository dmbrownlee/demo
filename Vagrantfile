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
    ansible.host_vars = {
      "pc-192.168.200.100" => {"nethost" => 100,
                             "disable_eth0" => "yes" },
      "pc-192.168.200.101" => {"nethost" => 101,
                             "disable_eth0" => "yes" },
      "pc-192.168.201.100" => {"nethost" => 100,
                             "disable_eth0" => "yes" },
      "pc-10.0.200.100" => {"nethost" => 100}
    }
    ansible.groups = {
      "net1" => ["pc-192.168.200.[100:101]"],
      "net2" => ["pc-192.168.201.100"],
      "net3" => ["pc-10.0.200.100"],
      "all_groups:children" => ["net1", "net2", "net3"],
      "net1:vars" => {"netprefix" => "192.168.200"},
      "net2:vars" => {"netprefix" => "192.168.201"},
      "net3:vars" => {"netprefix" => "10.0.200"}
    }
  end

  # PC on the first network
  config.vm.define "pc-192.168.200.100" do |node|
    node.vm.network "private_network", ip: "192.168.200.100", virtualbox__null: true, auto_config: false
    node.vm.provider "virtualbox" do |vb|
      vb.name = "pc-192.168.200.100"
      vb.customize ["modifyvm", :id, "--nic2", "null"]
    end
  end

  # PC on the second network
  config.vm.define "pc-192.168.201.100" do |node|
    node.vm.network "private_network", ip: "192.168.201.100", virtualbox__null: true, auto_config: false
    node.vm.provider "virtualbox" do |vb|
      vb.name = "pc-192.168.201.100"
      vb.customize ["modifyvm", :id, "--nic2", "null"]
    end
  end

  # Webserver/CA server on the first network
  config.vm.define "pc-192.168.200.101" do |node|
    node.vm.box = "ubuntu-15.10-server-amd64"
    node.vm.network "private_network", ip: "192.168.200.101", virtualbox__null: true, auto_config: false
    node.vm.provider "virtualbox" do |vb|
      vb.name = "pc-192.168.200.101"
      vb.customize ["modifyvm", :id, "--nic2", "null"]
    end
  end

  # NAT Firewall (if needed)
  config.vm.define "pc-10.0.200.100" do |node|
    node.vm.box = "ubuntu-15.10-server-amd64"
    node.vm.network "private_network", ip: "10.0.200.100", virtualbox__null: true, auto_config: false
    node.vm.provider "virtualbox" do |vb|
      vb.name = "pc-10.0.200.100"
      vb.customize ["modifyvm", :id, "--nic2", "null"]
    end
  end

end
