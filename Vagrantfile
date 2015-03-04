# -*- mode: ruby -*-
# vi: set ft=ruby :
# Parse options
options = {}

# ARV[1] = number of web servers
options[:port_guest] = ARGV[1] || 2



# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "precise32"
  config.vm.network "private_network", type: "dhcp"
  
  
  NODE_COUNT = options[:port_guest]
    NODE_COUNT.times do | i |
      node_id = "web#{i}"
      config.vm.define node_id do |node|
        node.vm.network :forwarded_port, guest: 80, host: "802#{i}"
        node.vm.hostname = "#{node_id}.local"
        node.vm.provision :chef_solo do |chef|
        chef.cookbooks_path = "cookbooks"
          chef.run_list = [
            'recipe[web::default]'
          ]
        end
      end
    end
  
  # config.vm.define :web1 do |box|
 #
 #    end
 #  end
 #
 #  config.vm.define :web2 do |box|
 #    box.vm.network :forwarded_port, guest: 80, host: 8022
 #    box.vm.hostname = "web2"
 #    box.vm.provision :chef_solo do |chef|
 #    chef.cookbooks_path = "cookbooks"
 #      chef.run_list = [
 #        'recipe[web::default]'
 #      ]
 #    end
 #  end
  
  # config.vm.define :lb do |box|
 #    box.vm.network :forwarded_port, guest: 80, host: 8000
 #    box.vm.hostname = "lb1"
 #
 #    box.vm.provision :chef_solo do |chef|
 #    chef.cookbooks_path = "cookbooks"
 #      chef.run_list = [
 #        'recipe[web::loadbalancer]'
 #      ]
 #    end
 #  end


end

