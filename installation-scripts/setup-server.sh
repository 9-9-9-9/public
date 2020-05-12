#!/bin/bash

# System update
sudo yum update -y

# Install docker
sudo yum install docker -y

# Config to run docker without sudo
sudo groupadd docker
sudo gpasswd -a $USER docker
sudo service docker restart

echo 'Please re-log'
