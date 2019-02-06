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

if hash docker 2>/dev/null; then
    echo "Docker exist"
else
    echo "Docker start install"
    sudo curl -sSL https://get.docker.com | sudo sh
    sudo apt-get install python-pip -y
    sudo pip install --upgrade setuptools
    sudo pip install docker-compose
fi

sudo docker-compose up --build -d