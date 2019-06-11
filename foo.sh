#! /usr/bin/bash

curl https://releases.hashicorp.com/vagrant/2.2.4/vagrant/vagrant_2.2.4_x86_64.deb > vagrant_2.2.4_x86_64.deb
sudo dpkg -i vagrant_2.2.4_x86_64.deb
vagrant plugin install vagrant-google


