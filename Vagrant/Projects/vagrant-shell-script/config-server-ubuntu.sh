#!/bin/bash
maquina="vagrant-shell-script"
usuario="lapadmin"

# Alterando nome da maquina
sudo hostnamectl set-hostname $maquina

sudo apt update -y  

# Instalando pacotes solicitados
sudo apt install vim curl telnet unzip wget net-tools htop nmap -y

# Criar o novo usuário
sudo useradd -m -s /bin/bash $usuario

# Definir a senha para o novo usuário
echo $usuario":Senha123" | sudo chpasswd

# Adicionar o novo usuário ao grupo sudo
sudo usermod -aG sudo $usuario