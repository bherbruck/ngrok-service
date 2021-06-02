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

wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-arm.zip -P ./
unzip ./ngrok-stable-linux-arm.zip
rm ./ngrok-stable-linux-arm.zip

mv ./ngrok /usr/local/bin/

mkdir -p /home/$SUDO_USER/.ngrok2/
cat > /home/$SUDO_USER/.ngrok2/ngrok.yml <<EOF
authtoken: $1

tunnels:
  ssh:
    proto: tcp
    addr: 22
EOF

cat > /etc/systemd/system/ngrok.service <<EOF
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
