#!/bin/bash

if [ -z "$1" ]; then
    echo "No authtoken supplied"
    exit 1
fi

wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-arm.zip -P ./
unzip ./ngrok-stable-linux-arm.zip
rm ./ngrok-stable-linux-arm.zip

sudo mv ./ngrok /usr/local/bin/

mkdir -p /home/$SUDO_USER/.ngrok2/
sudo cat >test1 <<EOF
authtoken: $1

tunnels:
  ssh:
    proto: tcp
    addr: 22
EOF

sudo cat >test2 <<EOF
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

sudo systemctl start ngrok
sudo systemctl enable ngrok
sudo systemctl status ngrok
