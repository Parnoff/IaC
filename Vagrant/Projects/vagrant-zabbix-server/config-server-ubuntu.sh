#!/bin/bash
maquina="vagrant-zabbix-server"
sudo hostnamectl set-hostname $maquina

sudo apt update -y  

sudo wget https://repo.zabbix.com/zabbix/6.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_6.0-4+ubuntu20.04_all.deb
sudo dpkg -i zabbix-release_6.0-4+ubuntu20.04_all.deb

sudo apt update -y

sudo apt install zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-sql-scripts zabbix-agent -y

sudo apt install mysql-server -y

sudo cat comando01.sql | sudo mysql -u root --password=''

sudo zcat /usr/share/zabbix-sql-scripts/mysql/server.sql.gz | sudo mysql --default-character-set=utf8mb4 -u zabbix -h localhost zabbix --password='zabbix'

sudo cat comando02.sql | sudo mysql -u root --password=''

sudo sed -i 's/# DBPassword=/DBPassword=zabbix/g' /etc/zabbix/zabbix_server.conf

sudo systemctl restart zabbix-server zabbix-agent apache2
sudo systemctl enable zabbix-server zabbix-agent apache2