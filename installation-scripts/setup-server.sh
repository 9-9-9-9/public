#!/bin/bash

# System update
sudo yum update -y

# Install docker
sudo yum install docker -y

# Config to run docker without sudo
sudo groupadd docker
sudo gpasswd -a vpsadmin docker
sudo service docker restart

# Setup alias
TMP=$(cat ~/.bashrc | grep '#my-alias starts')

if [ -z "$TMP" ]
then
	cp ~/.bashrc ~/.bashrc.bak
	cat ../_func/my-aliases.sh >> ~/.bashrc
fi

echo 'Please re-log'
