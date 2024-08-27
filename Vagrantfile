Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"
  
  config.vm.synced_folder "./", "/apps"

  config.vm.network "forwarded_port", guest: 24066, host: 24066
  
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "1024"
  end

  config.vm.provision "docker" do |d|
  end

  config.vm.provision "shell", privileged: true, inline: <<-SCRIPT
    apt update -y
    apt install -y make git curl
  SCRIPT
end