#!/bin/bash

usuario="ubuntu"

# Criar o novo usuário
sudo useradd -m $usuario

# Definir a senha para o novo usuário
echo $usuario":Senha123" | sudo chpasswd

# Adicionar o novo usuário ao grupo sudo
sudo usermod -aG sudo $usuario

# Instalando unzip
sudo apt install unzip -y

# Instalando o vim
sudo apt install vim -y

# Add Docker's official GPG key:
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Atualizando SO, após adicionar comandos do Docker no apt
sudo apt update -y  
sudo apt upgrade -y

# Instalando o Docker
sudo apt-get install docker-ce -y

# Gerando as chaves ssh para o usuário Ubuntu
sudo -u $usuario ssh-keygen -t rsa -b 2048 -f /home/$usuario/.ssh/id_rsa -N ""

# Autorize seu acesso ssh a VM
sudo bash -c 'echo "Informe aqui a chave pública SSH - arquivo id_rsa do Tipo Arquivo PUB (.pub)" >> /home/'$usuario'/.ssh/authorized_keys'

# Reiniciando o serviço do ssh
sudo systemctl restart ssh