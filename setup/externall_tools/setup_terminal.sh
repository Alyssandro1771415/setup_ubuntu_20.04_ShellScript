#!/bin/bash

# Instalando o fish shell
apt install fish

# Settando o fish shell como padrão
which fish
echo /usr/bin/fish | sudo tee -a /etc/shells
chsh -s /usr/bin/fish

PROFILE_ID=$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d "'")

BASE_PATH="org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/"

# Desativar cores do tema
gsettings set $BASE_PATH use-theme-colors false

# Cor do texto
gsettings set $BASE_PATH foreground-color 'rgb(0,255,0)'

# Cor do fundo
gsettings set $BASE_PATH background-color 'rgb(0,0,0)'

# Paleta personalizada
gsettings set $BASE_PATH palette "[
'rgb(0,0,0)',
'rgb(23,20,33)',
'rgb(192,28,40)', 
'rgb(5,221,182)', 
'rgb(162,115,76)', 
'rgb(154,13,240)', 
'rgb(163,71,186)', 
'rgb(42,161,179)', 
'rgb(208,207,204)', 
'rgb(94,92,100)', 
'rgb(246,97,81)', 
'rgb(59,72,246)', 
'rgb(233,173,12)', 
'rgb(42,215,222)', 
'rgb(59,247,140)', 
'rgb(51,199,222)', 
'rgb(255,255,255)']
"

# Instalação do neofetch
apt install neofetch -y

# Acionando a inicialização automática e direta do neofetch junto ao terminal
grep -qxF 'neofetch' ~/.config/fish/config.fish || echo 'neofetch' >> ~/.config/fish/config.fish
