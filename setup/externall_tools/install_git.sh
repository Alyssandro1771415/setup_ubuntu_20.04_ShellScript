#!/bin/bash

# Carregando as informações do .env
echo "USER_NAME_DATA: $USER_NAME_DATA"
echo "USER_EMAIL_DATA: $USER_EMAIL_DATA"

# Instalando o git
apt install git -y

# Settando as configurações de nome de usuário e email
git config --global user.name "$USER_NAME_DATA"
git config --global user.email "$USER_EMAIL_DATA"