#!/bin/bash
echo "Dowload frontend release"

curl http://89.223.31.207:5000/frontend/latest/download > ./frontend.zip
unzip -f ./frontend.zip -d ./frontend
rm ./frontend.zip

echo "Dowload server release"
curl http://89.223.31.207:5000/server/latest/download > ./server.zip
unzip -f ./server.zip -d ./server
rm ./server.zip

if hash docker 2>/dev/null; then
    echo "Docker exist"
else
    echo "Docker start install"
    sudo curl -sSL https://get.docker.com | sudo sh
fi

docker-compose up --build -d