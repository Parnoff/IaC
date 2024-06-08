#!/bin/bash
maquina="vagrant-shell-script-nginx"

# Atualizando SO, após adicionar comandos do Docker no apt
sudo apt update -y  

# Instalando o NGINX
sudo apt install nginx -y

sudo apt upgrade -y

# Alterando nome da máquina
sudo hostnamectl set-hostname $maquina

sudo rm /var/www/html/index.nginx-debian.html

sudo mv /tmp/site-template/* /var/www/html/

# Reiniciando NGINX
sudo systemctl restart nginx

