#!/bin/bash
maquina=$1
sudo hostnamectl set-hostname $maquina
echo "Nome do Host definido para $maquina"
echo "Atualizando pacotes"
sudo dnf update -y

sudo chmod 777 -R /home/vagrant
echo "Desabilitando SELinux"
sudo setenforce 0
sudo sed -i 's/^SELINUX=.*/SELINUX=disabled/g' /etc/selinux/config

echo "Instalando o PostgreSQL"
# sudo dnf module reset postgresql -y
sudo dnf module enable postgresql:15 -y
sudo dnf install -y postgresql-server postgresql
sudo postgresql-setup --initdb
sudo systemctl enable --now postgresql
echo $(psql --version)
echo "Atualizando a autenticacao para md5"
sudo sed -i 's/^\(local.*all.*all.*\)peer/\1md5/' /var/lib/pgsql/data/pg_hba.conf
sudo sed -i 's/^\(local.*all.*all.*\)ident/\1md5/' /var/lib/pgsql/data/pg_hba.conf
sudo sed -i 's/^\(host.*all.*all.*127.0.0.1\/32.*\)ident/\1md5/' /var/lib/pgsql/data/pg_hba.conf
sudo sed -i 's/^\(host.*all.*all.*127.0.0.1\/32.*\)peer/\1md5/' /var/lib/pgsql/data/pg_hba.conf
sudo sed -i 's/^\(host.*all.*all.*::1\/128.*\)ident/\1md5/' /var/lib/pgsql/data/pg_hba.conf
sudo sed -i 's/^\(host.*all.*all.*::1\/128.*\)peer/\1md5/' /var/lib/pgsql/data/pg_hba.conf
sudo systemctl restart postgresql

echo "Instalando o Zabbix"
sudo rpm -Uvh https://repo.zabbix.com/zabbix/7.0/oracle/8/x86_64/zabbix-release-latest-7.0.el8.noarch.rpm
sudo dnf clean all
sudo dnf module switch-to php:8.2 -y
sudo dnf -y install zabbix-server-pgsql zabbix-web-pgsql zabbix-apache-conf zabbix-sql-scripts zabbix-selinux-policy zabbix-agent
echo "Criando user Zabbix no PostgreSQL"
sudo -u postgres psql <<EOF
CREATE USER zabbix WITH PASSWORD 'zabbix';
CREATE DATABASE zabbix OWNER zabbix;
GRANT ALL PRIVILEGES ON DATABASE zabbix TO zabbix;
EOF
zcat /usr/share/zabbix-sql-scripts/postgresql/server.sql.gz | sudo -u zabbix psql zabbix
sudo sed -i 's/# DBPassword=/DBPassword=zabbix/g' /etc/zabbix/zabbix_server.conf
sudo systemctl restart zabbix-server zabbix-agent httpd php-fpm
sudo systemctl enable zabbix-server zabbix-agent httpd php-fpm
sudo systemctl status zabbix-server
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --reload
echo "The default URL for Zabbix UI when using Apache web server is http://host/zabbix"
sudo dnf clean all
sudo reboot 0