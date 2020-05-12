#!/bin/bash

export POSTGRES_PORT=5432
sudo docker run --restart unless-stopped -d -p $POSTGRES_PORT:$POSTGRES_PORT -v postgres:/data/db postgres:9.6

nmap -sT 127.0.0.1 -p $POSTGRES_PORT
