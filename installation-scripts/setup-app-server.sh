#!/bin/bash

[ "$(which node)" -eq "/usr/bin/node" ] && echo 'Node already installed' && exit 1

cd /tmp
curl -sL https://rpm.nodesource.com/setup_12.x | sudo bash -
sudo yum install nodejs -y

[ "$(node --version)" != "v12.16.3" ] && echo 'Failure on installing nodejs v12.16.3 LTS' && exit 1