#!/bin/bash

# Verifica se o script está sendo executado com permissões de superusuário
if [ "$EUID" -ne 0 ]; then
  echo "Por favor, execute como root."
  exit
fi

# Atualiza a lista de pacotes
echo "Atualizando a lista de pacotes..."
apt update

# Instala as dependências necessárias
echo "Instalando dependências necessárias..."
apt install -y wget gnupg


# --- Postman ---


sudo apt install flatpak -y
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install flathub com.getpostman.Postman -y

sudo apt update