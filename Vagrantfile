Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"
  config.vm.network "public_network"
  config.vm.synced_folder "./", "/apps/assinatura_digital"

  # config.ssh.username = "root"
  # config.ssh.password = "root"

  config.vm.provision "docker" do |d|
  end
  
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
  end
end