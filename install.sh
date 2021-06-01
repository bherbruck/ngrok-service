wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-arm.zip -P ./
unzip ./ngrok-stable-linux-arm.zip
rm ./ngrok-stable-linux-arm.zip

mkdir /home/$USER/.ngrok2
cp ./ngrok.yml /home/$USER/.ngrok2/ngrok.yml

sudo mv ./ngrok /usr/local/bin/
sudo cp ./ngrok.service /etc/systemd/system/ngrok.service

sudo systemctl start ngrok
sudo systemctl enable ngrok
sudo systemctl status ngrok
