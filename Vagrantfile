# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "hashicorp/precise64"
  config.vm.synced_folder "salt/roots/", "/srv/", :mount_options => ['dmode=777', 'fmode=777']
  config.vm.network :forwarded_port, host: 5000, guest: 8080
  config.vm.provision :salt do |salt|
    salt.minion_config = "salt/minion"
    salt.run_highstate = true
    salt.verbose = true
  end
end
