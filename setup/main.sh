#!/bin/bash

# Definir diretório base
base_dir="$(dirname "$0")"

echo "Ajustando permissões dos scripts..."
chmod +x "$base_dir"/externall_tools/*.sh
chmod +x "$base_dir"/vscode_extensions.sh

echo "Iniciando configuração do sistema..."

# Carrega o arquivo .env
echo "Carrgando informações do arquivo .env"

if [ -f "./.env" ]; then
  set -a        # exporta automaticamente todas as variáveis
  source .env
  set +a
else
  echo ".env não encontrado!"
  exit 1
fi

# Executar scripts de instalação
for script in "$base_dir"/externall_tools/*.sh; do
    if [ -f "$script" ]; then
        echo "Executando $(basename "$script")..."
        sudo -E bash "$script"
    else
        echo "Erro: Script $script não encontrado!"
    fi
done

# Executar script de extensões do VSCode
if [ -f "$base_dir/vscode_extensions.sh" ]; then
    echo "Instalando extensões do VSCode..."
    bash "$base_dir/vscode_extensions.sh"
else
    echo "Erro: vscode_extensions.sh não encontrado!"
fi

echo "Configuração concluída com sucesso!"
