#!/bin/bash

echo "Unpacking /var/ files"
cd ./var/
tar xzvf HPCCSystems.var.lib.tar.gz
cd ..

echo "Unpacking /etc/ files"
cd ../etc/
tar xzvf HPCCSystems.etc.tar.gz

echo "Now you can build docker images.."
echo "docker-compose -f docker-compose up --build"
