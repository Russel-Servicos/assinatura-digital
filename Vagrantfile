Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"
  
  config.vm.synced_folder "./", "/vagrant"

  config.vm.network "forwarded_port", guest: 24066, host: 24066
  
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "1024"
  end

  config.vm.provision "docker" do |d|
  end

  config.vm.provision "shell", privileged: true, inline: <<-SCRIPT
    apt-get update -y
    apt-get install -y make git curl
    cd /vagrant
    git clone https://github.com/Russel-Servicos/assinatura-digital.git ./assinatura
    cd ./assinatura
    make init-container
    make logs-container
  SCRIPT
end
