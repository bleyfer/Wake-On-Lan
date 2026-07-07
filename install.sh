#!/bin/bash

set -e

echo "=================================================="
echo "  Instalador de Wake On LAN Web Portal para Linux"
echo "=================================================="

# 1. Comprobar privilegios de root
if [ "$EUID" -ne 0 ]; then
  echo "❌ Por favor, ejecuta este script como root o usando sudo."
  exit 1
fi

# 2. Detectar arquitectura
ARCH=$(uname -m)
if [ "$ARCH" = "x86_64" ]; then
  ASSET_SUFFIX="linux-x64.zip"
  echo "✅ Arquitectura detectada: x64 (Intel/AMD)"
elif [ "$ARCH" = "aarch64" ] || [ "$ARCH" = "arm64" ]; then
  ASSET_SUFFIX="linux-arm64.zip"
  echo "✅ Arquitectura detectada: ARM64 (Raspberry Pi 64-bits / ARM Server)"
else
  echo "❌ Arquitectura no soportada: $ARCH"
  exit 1
fi

# 3. Dependencias necesarias
echo "📦 Verificando dependencias (curl, unzip, jq)..."
apt-get update -qq && apt-get install -y -qq curl unzip jq libicu-dev

# 4. Obtener la última versión de GitHub
echo "🔍 Buscando la última versión en GitHub..."
REPO="bleyfer/Wake-On-Lan"
API_URL="https://api.github.com/repos/$REPO/releases/latest"

LATEST_JSON=$(curl -s $API_URL)
TAG_NAME=$(echo "$LATEST_JSON" | jq -r '.tag_name')

if [ "$TAG_NAME" = "null" ] || [ -z "$TAG_NAME" ]; then
  echo "❌ No se pudo obtener la última versión. Verifica el repositorio."
  exit 1
fi

echo "🚀 Descargando versión $TAG_NAME..."
DOWNLOAD_URL=$(echo "$LATEST_JSON" | jq -r ".assets[] | select(.name | endswith(\"$ASSET_SUFFIX\")) | .browser_download_url")

if [ -z "$DOWNLOAD_URL" ]; then
  echo "❌ No se encontró el archivo $ASSET_SUFFIX en el release $TAG_NAME."
  exit 1
fi

# 5. Descargar y descomprimir
INSTALL_DIR="/opt/wakeonlan"
TMP_ZIP="/tmp/wakeonlan_$TAG_NAME.zip"

curl -sL "$DOWNLOAD_URL" -o "$TMP_ZIP"

echo "📂 Instalando en $INSTALL_DIR..."
rm -rf "$INSTALL_DIR"
mkdir -p "$INSTALL_DIR"
unzip -q "$TMP_ZIP" -d "$INSTALL_DIR"
rm -f "$TMP_ZIP"

# Dar permisos de ejecución
chmod +x "$INSTALL_DIR/wakeOnLan"

# 6. Crear el servicio Systemd
echo "⚙️ Configurando el servicio de sistema (Systemd)..."

cat <<EOF > /etc/systemd/system/wakeonlan.service
[Unit]
Description=Wake On LAN Web Portal
After=network.target

[Service]
WorkingDirectory=$INSTALL_DIR
ExecStart=$INSTALL_DIR/wakeOnLan
Restart=always
RestartSec=10
KillSignal=SIGINT
SyslogIdentifier=wakeonlan
User=root
Environment=ASPNETCORE_ENVIRONMENT=Production
Environment=DOTNET_PRINT_TELEMETRY_MESSAGE=false

[Install]
WantedBy=multi-user.target
EOF

# 7. Iniciar servicio
systemctl daemon-reload
systemctl enable wakeonlan.service
systemctl restart wakeonlan.service

echo "=================================================="
echo "✅ ¡Instalación completada con éxito!"
echo "🌐 Accede al portal web abriendo en tu navegador:"
echo "   http://<IP-DE-ESTE-SERVIDOR>:5100"
echo ""
echo "📊 Para ver los logs del sistema usa:"
echo "   journalctl -fu wakeonlan.service"
echo "=================================================="
