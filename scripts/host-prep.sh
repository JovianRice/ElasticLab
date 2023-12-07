#!/bin/bash

# Install VirtualBox GPG Keys & add VirtualBox Repository for Debian 12
wget -O- -q https://www.virtualbox.org/download/oracle_vbox_2016.asc | sudo gpg --dearmour -o /usr/share/keyrings/oracle_vbox_2016.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/oracle_vbox_2016.gpg] http://download.virtualbox.org/virtualbox/debian bookworm contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list

# Update package list
sudo apt update

# Packages to install
packages=("vim" "git" "vagrant" "virtualbox-7.0" "python3-pip")

# Install packages
for package in "${packages[@]}"
do
    sudo apt install -y $package
done

# Install Vagrant plugins
vagrant_plugins=("vagrant-reload" "vagrant-vbguest")

for plugin in "${vagrant_plugins[@]}"
do
    vagrant plugin install $plugin
done

# Install WinRM-related Ruby gems
sudo gem install -N winrm winrm-fs winrm-elevated

# Display installed versions
echo "Installed versions:"
echo "-------------------"
vim --version | head -n 1
git --version
vagrant --version
ansible --version
VBoxManage --version
python3 --version

echo "Installed Vagrant plugins:"
vagrant plugin list

sudo usermod -a -G vboxusers $USER
echo "User added to vboxusers group."
groups $USER

echo "Prerequisites installed. Host now ready for installation of lab environment."
