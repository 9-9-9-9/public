#!/bin/bash

USERID=$1

if [ -z "$USERID"]
then
	echo 'Must provide user id as first parameter (this user will be added to docker group)'
	exit 1
fi

# System update
sudo yum update -y

# Install docker
sudo yum install docker -y

# Config to run docker without sudo
sudo groupadd docker
sudo gpasswd -a $USERID docker
sudo service docker restart

echo 'Please re-log'
