maquina="srv-docker01"

# Instalando unzip
sudo apt install unzip -y

# Instalando o vim
sudo apt install vim -y

# Atualizando SO, após adicionar comandos do Docker no apt
sudo apt update -y  
sudo apt upgrade -y

# Instalando o Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# Atualizando SO, após adicionar comandos do Docker no apt
sudo apt update -y  
sudo apt upgrade -y

# Alterando nome da máquina
sudo hostnamectl set-hostname $maquina