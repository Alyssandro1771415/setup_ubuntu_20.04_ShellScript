#!/bin/bash
set -e

# Verifica se está rodando como root
if [ "$EUID" -ne 0 ]; then
  echo "Por favor, execute como root."
  exit 1
fi

echo "Removendo versões antigas do Docker (se existirem)..."
apt remove -y docker docker-engine docker.io containerd runc || true

echo "Atualizando pacotes..."
apt update

echo "Instalando dependências..."
apt install -y ca-certificates curl gnupg

echo "Criando diretório para keyrings..."
install -m 0755 -d /etc/apt/keyrings

echo "Adicionando chave GPG do Docker..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
  | gpg --dearmor -o /etc/apt/keyrings/docker.gpg

chmod a+r /etc/apt/keyrings/docker.gpg

echo "Adicionando repositório oficial do Docker..."
ARCH=$(dpkg --print-architecture)
CODENAME=$( . /etc/os-release && echo "$VERSION_CODENAME" )

echo \
  "deb [arch=$ARCH signed-by=/etc/apt/keyrings/docker.gpg] \
https://download.docker.com/linux/ubuntu $CODENAME stable" \
> /etc/apt/sources.list.d/docker.list

echo "Atualizando pacotes com repositório Docker..."
apt update

echo "Instalando Docker Engine, CLI e plugins..."
apt install -y \
  docker-ce \
  docker-ce-cli \
  containerd.io \
  docker-buildx-plugin \
  docker-compose-plugin

echo "Habilitando e iniciando o Docker..."
systemctl enable docker
systemctl start docker

echo "Configurando uso do Docker sem sudo..."
TARGET_USER=${SUDO_USER:-$USER}
usermod -aG docker "$TARGET_USER"

echo "Docker instalado com sucesso 🎉"
echo
echo "⚠️ IMPORTANTE:"
echo "Faça logout/login ou reinicie para usar Docker sem sudo."
