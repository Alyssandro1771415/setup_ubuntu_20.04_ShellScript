#!/bin/bash
set -e

# Settando endereço de download e arquivo baixado
URL="https://dbschema.com/download/dbschema_linux_10_0_2.sh"
ARQUIVO="dbschema_installer.sh"

echo "Baixando DbSchema..."
wget -q -O "$ARQUIVO" "$URL"

echo "Tornando executável..."
chmod +x "$ARQUIVO"

# Modo silencioso para não haver necessidade de processos manuais pelo usuário através de interface gráfica
echo "Instalando DbSchema em modo silencioso..."
./"$ARQUIVO" \
  -q \
  -Duser.language=pt \
  -Duser.country=BR \
  -Djava.awt.headless=true

echo "Removendo arquivo de instalação"
rm ../dbschema_installer.sh

echo "Instalação finalizada."
