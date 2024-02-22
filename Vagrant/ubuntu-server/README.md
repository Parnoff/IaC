# Guia de Instruções - Configuração do Vagrant

Este guia fornece instruções passo a passo para configurar e usar o Vagrant para criar e gerenciar ambientes de desenvolvimento virtualizados.

## Instalação do Vagrant

Para instalar o Vagrant, siga estas etapas:

1. Baixe e instale o Vagrant a partir do site oficial: [Vagrant Downloads](https://www.vagrantup.com/downloads).

2. Siga as instruções de instalação para o seu sistema operacional.

## Baixe o Vagrantfile e Scripts

1. Clone ou baixe este repositório para o seu computador local.

2. Navegue até o diretório onde o repositório foi clonado ou baixado.

## Acesso ao Diretório do Projeto com Terminal (CMD)

1. Abra o terminal (ou CMD no Windows).

2. Navegue até o diretório onde o repositório foi clonado ou baixado usando o comando `cd`.

   ```bash
   cd caminho/para/o/diretorio/do/projeto

## Configuração do Arquivo de Script
1. Abra o arquivo de script (por exemplo, bootstrap.sh) em um editor de texto.

2. Configure o arquivo de script com suas especificações, como pacotes a serem instalados, configurações de ambiente, endereço IP, etc.

3. Salve as alterações no arquivo de script. 💻

## Configuração do Vagrantfile
1. Abra o arquivo Vagrantfile em um editor de texto.

2. Verifique e ajuste as configurações do Vagrantfile conforme necessário, incluindo o tipo de virtualizador (por exemplo, VirtualBox, VMware), a quantidade de memória, CPU, etc.

3. Salve as alterações no arquivo Vagrantfile.

## Comando vagrant up
Por fim, para iniciar o ambiente virtual, use o comando vagrant up no terminal no diretório do projeto:

`vagrant up`

Este comando cria e provisiona a máquina virtual de acordo com as configurações especificadas no Vagrantfile e nos scripts de provisionamento. 🚀