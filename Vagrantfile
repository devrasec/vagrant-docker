# -*- mode: ruby -*-
# vi: set ft=ruby :

# Web Development Environment with Vagrant and Docker
# Author: Luis Contreras <luiscon26@gmail.com>
# Version: 1.1.1

# Load configuration file.
require 'yaml'
dir = File.dirname(File.expand_path(__FILE__))
unless File.exists?("#{dir}/config.yml")
  raise 'Configuration file not found! Please copy example.config.yml to config.yml and try again.'
end
vmconfig = YAML.load_file("#{dir}/config.yml")

Vagrant.configure(2) do |config|
  # Uncomment the following line to disable plugin
  # `vagrant-gatling-rsync` on startup.
  # config.gatling.rsync_on_startup = false

  # Disable checking for latest box
  config.vm.box_check_update = false

  # Virtualbox modifications
  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
    v.cpus = 1
  end

  config.vm.define "webdev-vm", primary: true do |webdev|
    webdev.vm.box = "ubuntu/trusty64"
    webdev.vm.hostname = "docker-host"

    # Networking
    webdev.vm.network "private_network", ip: vmconfig["ip"] ||= "192.168.10.10"

    # Synced folders configuration
    # Disable default /vagrant share
    webdev.vm.synced_folder ".", "/vagrant", disabled: true

    # NFS global options
    config.nfs.map_uid = Process.uid
    config.nfs.map_gid = Process.gid

    vmconfig['synced_folders'].each do |path|
      if path['active'] then
        options = {
          type: 'nfs',
          create: path['create'] ||= false,
          nfs_udp: false,
          mount_options: ['defaults', 'tcp', 'actimeo=2'].concat(path['mount_options']),
        }
        webdev.vm.synced_folder "#{path['source_path']}", "#{path['target_path']}-nfs", options

        # Use `vagrant-bindfs` to correct permissions, a problem with NFS mounts
        bind_options = {
          force_user: path['user'] ||= 'vagrant',
          force_group: path['group'] ||= 'vagrant',
          create_with_perms: "u=rwX:g=rD:o=rD"
        }
        config.bindfs.bind_folder "#{path['target_path']}-nfs", "#{path['target_path']}", bind_options
      end
    end

    # Provisioning with Ansible.
    webdev.vm.provision "ansible" do |ansible|
      ansible.playbook = "provision/ansible/playbook.yml"
    end

    # Shell provisioning.
    # Bind the Docker daemon to a TCP port so that the client (running on the host)
    # can interact with it.
    # webdev.vm.provision "shell", path: "provision/shell/docker_bind_port.sh"
  end
end
