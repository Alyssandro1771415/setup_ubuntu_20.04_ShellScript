#!/bin/bash

# Instalando o Flatpak
sudo apt update
sudo apt install flatpak -y

# Adicionando o repo do Flatpak
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

#Instalando o Hidamari
flatpak install flathub io.github.jeffshee.Hidamari
