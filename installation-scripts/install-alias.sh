#!/bin/bash

# Setup alias
TMP=$(cat ~/.bashrc | grep '#my-alias starts')

if [ -z "$TMP" ]
then
	cp ~/.bashrc ~/.bashrc.bak
	cat ../_funcs/my-aliases.sh >> ~/.bashrc
fi

source ~/.bashrc

echo 'Please re-log or re-connect'
