wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-arm.zip -P ~
unzip ngrok-stable-linux-amd64.zip
rm ngrok-stable-linux-amd64.zip
sudo mv ngrok /usr/local/bin/
mv ngrok.yml ~/.ngrok2/ngrok.yml
sudo cp ngrok.service /etc/systemd/system/ngrok.service
sudo systemctl start ngrok
sudo systemctl enable ngrok
sudo systemctl status ngrok
