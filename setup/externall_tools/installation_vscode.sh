#!/bin/bash
set -e

# Verifica se o script está sendo executado como root
if [ "$EUID" -ne 0 ]; then
  echo "Por favor, execute como root."
  exit 1
fi

echo "Atualizando a lista de pacotes..."
apt update

echo "Instalando dependências..."
apt install -y wget gpg apt-transport-https

echo "Adicionando chave GPG da Microsoft..."
wget -qO- https://packages.microsoft.com/keys/microsoft.asc \
  | gpg --dearmor \
  > /etc/apt/keyrings/packages.microsoft.gpg

chmod 644 /etc/apt/keyrings/packages.microsoft.gpg

echo "Adicionando repositório do VS Code..."
echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] \
https://packages.microsoft.com/repos/code stable main" \
> /etc/apt/sources.list.d/vscode.list

echo "Atualizando pacotes após adicionar o repositório..."
apt update

echo "Instalando o Visual Studio Code..."
apt install -y code

echo "Instalação do Visual Studio Code concluída 🎉"

echo "Configurando VS Code para remover espaços em branco à direita..."

TARGET_USER=${SUDO_USER:-$USER}
USER_HOME=$(getent passwd "$TARGET_USER" | cut -d: -f6)

VSCODE_SETTINGS_DIR="$USER_HOME/.config/Code/User"
VSCODE_SETTINGS_FILE="$VSCODE_SETTINGS_DIR/settings.json"

mkdir -p "$VSCODE_SETTINGS_DIR"

# Se o arquivo não existir, cria com a configuração
if [ ! -f "$VSCODE_SETTINGS_FILE" ]; then
  cat <<EOF > "$VSCODE_SETTINGS_FILE"
{
  "files.trimTrailingWhitespace": true
}
EOF
else
  # Se já existir, garante que a configuração esteja presente
  if ! grep -q '"files.trimTrailingWhitespace"' "$VSCODE_SETTINGS_FILE"; then
    sed -i '1s/{/{\n  "files.trimTrailingWhitespace": true,/' "$VSCODE_SETTINGS_FILE"
  fi
fi

chown -R "$TARGET_USER":"$TARGET_USER" "$USER_HOME/.config"

