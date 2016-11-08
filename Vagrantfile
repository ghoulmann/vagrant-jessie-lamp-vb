# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "debian/jessie64"
  config.vm.hostname = "jessie-lamp"
  config.vm.network "private_network", ip: "192.168.33.22"
  config.vm.synced_folder "www/", "/var/www/html",
    owner: "root", group: "www-data"
  config.vm.provision :shell, path: "bootstrap.sh"
  config.vm.network "forwarded_port", guest: 80, host: 8080
end
