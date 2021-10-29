# ngrok-service

Easily install ngrok as a service on a Raspberry Pi!

## 💿 Installation

1. Copy your auth token at https://dashboard.ngrok.com/get-started/your-authtoken

2. Clone the repo

```sh
git clone https://github.com/bherbruck/ngrok-service
```

3. `cd` into the repo

```sh
cd ngrok-service
```

4. Run the setup script with your copied auth token

```sh
sudo bash setup.sh <your-authtoken>
```

## ⚠ Warning

This might overwrite your ngrok.yml

Currently only downloads the 32-bit ARM version of ngrok
