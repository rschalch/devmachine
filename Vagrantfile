# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  
  config.vm.box = "ubuntu/trusty64"
  config.vm.hostname = "devmachine"
  config.vm.box_check_update = true
  config.vm.provision :shell, :path => "provision.sh"

  config.vm.network "forwarded_port", guest: 80, host: 8000, id: "nginx"
  config.vm.network "forwarded_port", guest: 3000, host: 3000, id: "rails"

  config.vm.network "private_network", ip: "192.168.100.100"

  config.vm.provider "virtualbox" do |vb|
  	vb.memory = "768"
  end
end
