#!/bin/bash

if [ -z "$1" ]; then
  echo "no authtoken supplied"
  echo "get yours at https://dashboard.ngrok.com/get-started/your-authtoken"
  echo "sudo bash install.sh <your-authtoken>"
  exit 1
fi

if [ "$EUID" -ne 0 ]; then
  echo "must run as root"
  exit 1
fi


OS=$(uname -s | tr '[:upper:]' '[:lower:]')
ARCH=$(uname -m)

DOWNLOAD_PATH=/tmp/ngrok.tgz
DOWNLOAD_FILE=""

case $ARCH in
  "x86_64")
    DOWNLOAD_FILE="ngrok-v3-stable-linux-amd64.tgz"
    ;;
  "i386")
    DOWNLOAD_FILE="ngrok-v3-stable-linux-386.tgz"
    ;;
  "armv7l")
    DOWNLOAD_FILE="ngrok-v3-stable-linux-arm.tgz"
    ;;
  "aarch64")
    DOWNLOAD_FILE="ngrok-v3-stable-linux-arm64.tgz"
    ;;
  *)
    echo "unsupported architecture: $ARCH"
    exit 1
    ;;
esac

curl -L https://bin.equinox.io/c/bNyj1mQVY4c/$DOWNLOAD_FILE -o $DOWNLOAD_PATH --compressed
tar -xvzf $DOWNLOAD_PATH -C /tmp
mv /tmp/ngrok /usr/local/bin/ngrok

mkdir -p /home/$SUDO_USER/.ngrok2/
cat > /home/$SUDO_USER/.ngrok2/ngrok.yml << EOF
authtoken: $1
version: '2'
tunnels:
  ssh:
    proto: tcp
    addr: 22
EOF

chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/.ngrok2


cat > /etc/systemd/system/ngrok.service << EOF
[Service]
Type=simple
User=$SUDO_USER
WorkingDirectory=/home/$SUDO_USER
ExecStart=/usr/local/bin/ngrok start --all
Restart=always
RestartSec=10
[Install]
WantedBy=multi-user.target
EOF


systemctl daemon-reload
systemctl start ngrok
systemctl enable ngrok
systemctl status ngrok
