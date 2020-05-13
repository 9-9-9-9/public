#!/bin/bash

source ./my-env.sh

export NEO4J_HTTP_PORT=7474
export NEO4J_BOLT_PORT=7687
sudo docker run \
	--name neo4j-v3 \
	--restart unless-stopped \
	-d \
	-p $NEO4J_HTTP_PORT:$NEO4J_HTTP_PORT \
	-p $NEO4J_BOLT_PORT:$NEO4J_BOLT_PORT \
	-v neo4j-v3:/data/db \
	-v conf-neo4j-v3:/conf \
	--env NEO4J_AUTH=$NEO4J_USERNAME/$NEO4J_PWD \
	neo4j:3.5.3

nmap -sT 127.0.0.1 -p $NEO4J_HTTP_PORT
nmap -sT 127.0.0.1 -p $NEO4J_BOLT_PORT
