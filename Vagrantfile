# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "generic/centos9s"

  config.vm.provision "file", source: "hello-world-app.1.0.0.rpm", destination: "/home/vagrant/hello-world-app.1.0.0.rpm"

  config.vm.provision "shell", inline: <<-SHELL
    dnf install -y dotnet-runtime-6.0 && \
    dnf install -y /home/vagrant/hello-world-app.1.0.0.rpm && \
    dotnet /usr/share/hello-world-app/hello-world-app.dll
  SHELL
end
