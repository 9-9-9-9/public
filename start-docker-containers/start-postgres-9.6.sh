#!/bin/bash

source ./my-env.sh

export POSTGRES_PORT=5432

docker run \
	--name $CONTAINER_POSTGRES_9_NAME \
	--restart unless-stopped \
	-d \
	-p $POSTGRES_PORT:$POSTGRES_PORT \
	-v postgres:/var/lib/postgresql/data \
	-e POSTGRES_PASSWORD=$POSTGRES_PWD \
	postgres:9.6

nmap -sT 127.0.0.1 -p $POSTGRES_PORT
