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
      "pc-192.168.1.100" => {"nethost" => 100,
                             "disable_eth0" => "yes" },
      "pc-192.168.1.101" => {"nethost" => 101,
                             "disable_eth0" => "yes" },
      "pc-192.168.1.102" => {"nethost" => 102,
                             "disable_eth0" => "yes" },
      "pc-172.16.0.100" => {"nethost" => 100,
                            "disable_eth0" => "yes" },
      "pc-172.16.0.101" => {"nethost" => 101,
                            "disable_eth0" => "yes" },
      "pc-172.16.0.102" => {"nethost" => 102,
                            "disable_eth0" => "yes" },
      "pc-10.0.0.100" => {"nethost" => 100}
    }
    ansible.groups = {
      "net1" => ["pc-192.168.1.[100:102]"],
      "net2" => ["pc-172.16.0.[100:102]"],
      "net3" => ["pc-10.0.0.100"],
      "all_groups:children" => ["net1", "net2", "net3"],
      "net1:vars" => {"netprefix" => "192.168.1"},
      "net2:vars" => {"netprefix" => "172.16.0"},
      "net3:vars" => {"netprefix" => "10.0.0"}
    }
  end

  # For each of these networks...
  ["192.168.1","172.16.0"].each do |net|
    # ... configure these three nodes
    (100..102).each do |host|
      config.vm.define "pc-#{net}.#{host}" do |node|
        node.vm.network "private_network", ip: "#{net}.#{host}", virtualbox__null: true, auto_config: false
        node.vm.provider "virtualbox" do |vb|
          vb.name = "pc-#{net}.#{host}"
          vb.customize ["modifyvm", :id, "--nic2", "null"]
        end
      end
    end
  end

  config.vm.define "pc-10.0.0.100" do |node|
    node.vm.network "private_network", ip: "10.0.0.100", virtualbox__null: true, auto_config: false
    node.vm.provider "virtualbox" do |vb|
      vb.name = "pc-10.0.0.100"
      vb.customize ["modifyvm", :id, "--nic2", "null"]
    end
  end
end
