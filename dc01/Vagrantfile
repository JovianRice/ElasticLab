# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # Set the virtual machine name
  #config.vm.define "DC01"
  
  # Set the base box to the JovianRice/DC01 box on Vagrant site.
  config.vm.box = "JovianRice/DC01"

  # Enable the VirtualBox provider
  config.vm.provider "virtualbox" do |vb|
    # Set the VM name in VirtualBox
    vb.name = "DC01"

    # Configure the network interfaces
    vb.customize ["modifyvm", :id, "--nic1", "nat"]
    vb.customize ["modifyvm", :id, "--nic2", "hostonly", "--hostonlyadapter2", "vboxnet0"]

    # Increase the amount of Memory to 8 GB, number of CPUs to 4, and sets VRAM to 128 MB.
    vb.memory = 4096
    vb.cpus = 2
    vb.customize ["modifyvm", :id, "--vram", "128"]
  end

  # Configure the private network with a static IP address on vboxnet0
  config.vm.network "private_network", ip: "192.168.56.10"

end
