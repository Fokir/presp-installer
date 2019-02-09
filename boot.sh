#!/bin/bash
echo "Update system components"
sudo apt-get update -y
sudo apt-get upgrade -y

echo "Dowload frontend release"
curl http://89.223.31.207:5000/frontend/latest/download > ./frontend.zip
unzip ./frontend.zip -d ./frontend
rm ./frontend.zip

echo "Dowload server release"
curl http://89.223.31.207:5000/server/latest/download > ./server.zip
unzip ./server.zip -d ./server
rm ./server.zip

echo "Install mqtt"
sudo wget http://repo.mosquitto.org/debian/mosquitto-repo.gpg.key
sudo apt-key add mosquitto-repo.gpg.key
cd /etc/apt/sources.list.d/
sudo wget http://repo.mosquitto.org/debian/mosquitto-stretch.list
sudo apt-get update
sudo apt-get install mosquitto
sudo apt-get install mosquitto mosquitto-clients

sudo /etc/init.d/mosquitto stop

sudo cp ./mosquitto.conf /etc/mosquitto/mosquitto.conf

sudo /etc/init.d/mosquitto start

echo "Install mDNS"
sudo apt-get install avahi-daemon -y
sudo apt-get install avahi-utils -y

sudo cp ./avahi-daemon.conf /etc/avahi/avahi-daemon.conf

sudo apt-get install libnss-mdns -y

sudo cp ./nsswitch.conf /etc/nsswitch.conf

echo "Install nodejs"
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
sudo apt-get install -y nodejs

npm install npm@latest -g

echo "Install pm2"
npm i -g pm2

pm2 start ./server/main.js --name server
pm2 save
pm2 startup

echo "Install success"