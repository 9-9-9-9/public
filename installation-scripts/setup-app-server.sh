#!/bin/bash

if [ "$EUID" -ne 0 ]
then 
	echo "Please run with sudo"
	exit 1
fi

# install nodejs
if [[ "$(which node)" =~ 'bin/node' ]]
then
	echo 'Node already installed'
else
	cd /tmp
	curl -sL https://rpm.nodesource.com/setup_12.x | sudo bash -
	sudo yum install nodejs -y

	[ "$(node --version)" != "v12.16.3" ] && echo 'Failure on installing nodejs v12.16.3 LTS' && exit 1
fi

# downgrade npm if version is 6.14.* which has bug with connection

if [[ "$(npm --version)" =~ 6.13 ]]
then
	echo 'Good npm version'
elif [[ "$(npm --version)" =~ 6.14 ]]
then
	echo 'Current version of npm is 6.14.* has bug and should be downgraded'
	sudo npm install -g npm@6.13.7
fi

# Install Angular CLI

if [[ "$(which ng)" =~ 'bin/ng' ]]
then
	echo 'Angular CLI already installed'
else
	sudo npm install -g @angular/cli
fi
