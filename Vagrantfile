# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|

  config.vm.define :ubuntu do |ubuntu|
    ubuntu.vm.box = 'precise64'
    ubuntu.vm.box_url = 'http://files.vagrantup.com/precise64.box'
  end

  config.vm.define :centos do |centos|
    centos.vm.box = 'centos64'
    centos.vm.box_url = 'http://puppet-vagrant-boxes.puppetlabs.com/centos-64-x64-vbox4210.box'
  end

  config.vm.provision :puppet do |puppet|
     puppet.module_path    = ".."
     puppet.manifests_path = "tests"
     puppet.manifest_file  = "init.pp"
  end
end
