#!/bin/bash

source ../_funcs/my-env.sh

export ELASTIC_REST_PORT=9200
export ELASTIC_NODES_COM_PORT=9300

docker run \
	--name $CONTAINER_ELASTIC_6_NAME \
	--restart unless-stopped \
	-d \
	-p $ELASTIC_REST_PORT:$ELASTIC_REST_PORT \
	-p $ELASTIC_NODES_COM_PORT:$ELASTIC_NODES_COM_PORT \
	-v data-elastic-v6:/usr/share/elasticsearch/data \
	-e "discovery.type=single-node" \
	elasticsearch:$DOCKER_IMG_ELASTICSEARCH_V6

nmap -sT 127.0.0.1 -p $ELASTIC_REST_PORT,$ELASTIC_NODES_COM_PORT
