#!/bin/bash

# Setup alias
TMP=$(cat ~/.bashrc | grep '#my-alias starts')

if [ -z "$TMP" ]
then
	cp ~/.bashrc ~/.bashrc.bak
	cat ../_func/my-aliases.sh >> ~/.bashrc
fi

source ~/.bashrc
