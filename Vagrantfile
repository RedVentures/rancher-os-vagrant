# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'

# Read in the config.yaml file
vagrant_root = File.dirname(__FILE__) 
yaml    = YAML.load_file(vagrant_root + '/config.yml')
servers = yaml['servers']

Vagrant.configure(2) do |config|
  servers.each_with_index do |server, server_num|
    config.vm.define server['name'] do |node|
      ip = "172.19.8.#{server_num+100}"
      node.vm.box = "RV/centos-7-x86_64"
      node.vm.box_url = "http://kickstart.redventures.net/boxes/RV-centos-7-x86_64.json"
      node.vm.provision "file", source:  vagrant_root + "/load-balancer/docker-compose.yml", destination: "/tmp/docker-compose.yml"
      node.vm.provision "file", source:  vagrant_root + "/load-balancer/rancher-compose.yml", destination: "/tmp/rancher-compose.yml"
      node.vm.provision "shell", path: vagrant_root + server['init_script']
      node.vm.hostname = server['name']
      node.vm.network "private_network", ip: ip
      node.vm.provider "virtualbox" do |v|
        v.name   = server['name']
      end
    end
  end
end

#config.vm.provision "file", source: "~/.gitconfig", destination: ".gitconfig"