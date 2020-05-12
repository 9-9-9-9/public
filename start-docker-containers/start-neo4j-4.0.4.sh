#!/bin/bash

export NEO4J_HTTP_PORT=7474
export NEO4J_BOLT_PORT=7687
sudo docker run \
	--restart unless-stopped \
	-d \
	-p $NEO4J_HTTP_PORT:$NEO4J_HTTP_PORT \
	-p $NEO4J_BOLT_PORT:$NEO4J_BOLT_PORT \
	-v neo4j-v4:/data/db \
	-v conf-neo4j-v4:/conf \
	--env NEO4J_AUTH=neo4j/1234567 \
	neo4j:4.0.4

nmap -sT 127.0.0.1 -p $NEO4J_HTTP_PORT
nmap -sT 127.0.0.1 -p $NEO4J_BOLT_PORT
