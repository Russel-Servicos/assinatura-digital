Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"
  config.vm.synced_folder "./", "/apps"

  config.vm.network "forwarded_port", guest: 24066, host: 24066

  config.vm.provision "docker" do |d|
  end
  
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "1024"
  end
end