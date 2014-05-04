require 'fileutils'

$serial_logging = false
$virtual_memory = 2048
$virtual_cpus = 2
$virtual_ip = "172.22.2.2"
$vm_name = "dev-core"

Vagrant.require_version ">= 1.4.0"

Vagrant.configure("2") do |config|
  config.vm.box = "phusion-open-ubuntu-14.04-amd64"
  config.vm.box_url = "https://oss-binaries.phusionpassenger.com/vagrant/boxes/latest/ubuntu-14.04-amd64-vbox.box"

  config.vm.provider :vmware_fusion do |vb, override|
    override.vm.box_url = "https://oss-binaries.phusionpassenger.com/vagrant/boxes/latest/ubuntu-14.04-amd64-vmwarefusion.box"
  end

  config.vm.hostname = $vm_name

  if $serial_logging
    logdir = File.join(File.dirname(__FILE__), "log")
    FileUtils.mkdir_p(logdir)

    serialFile = File.join(logdir, "%s-serial.txt" % $vm_name)
    FileUtils.touch(serialFile)

    config.vm.provider :vmware_fusion do |v, override|
      v.vmx["serial0.present"] = "TRUE"
      v.vmx["serial0.fileType"] = "file"
      v.vmx["serial0.fileName"] = serialFile
      v.vmx["serial0.tryNoRxLoss"] = "FALSE"
    end

    config.vm.provider :virtualbox do |v, override|
      v.customize ["modifyvm", :id, "--uart1", "0x3F8", "4"]
      v.customize ["modifyvm", :id, "--uartmode1", serialFile]
    end
  end

  config.vm.provider :vmware_fusion do |v, override|
    v.gui = false
    v.vmx["memsize"] = $virtual_memory.to_s
    v.vmx["numvcpus"] = $virtual_cpus.to_s
  end

  config.vm.provider :virtualbox do |v|
    v.gui = false
    v.memory = $virtual_memory
    v.cpus = $virtual_cpus
  end

  config.ssh.forward_agent = true
  config.vm.network :private_network, ip: $virtual_ip

  config.vm.provision :chef_solo do |chef|
    chef.custom_config_path = "Vagrantfile.chef"
    chef.cookbooks_path = ["cookbooks", "local_cookbooks"]
    chef.log_level = ENV.fetch("CHEF_LOG", "info").downcase.to_sym

    chef.add_recipe "apt"
    chef.add_recipe "dev::packages"

    chef.add_recipe "ssh_known_hosts"
    chef.add_recipe "dev::ssh"
    chef.add_recipe "dev::dotfiles"
    chef.add_recipe "dev::misc"
  end
end
