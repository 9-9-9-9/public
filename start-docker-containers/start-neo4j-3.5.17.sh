#!/bin/bash

export NEO4J_HTTP_PORT=7474
export NEO4J_BOLT_PORT=7687
sudo docker run --restart unless-stopped -d -p $NEO4J_HTTP_PORT:$NEO4J_HTTP_PORT -p $NEO4J_BOLT_PORT:$NEO4J_BOLT_PORT -v neo4j-v3:/data/db --env NEO4J_AUTH=none neo4j:3.5.17

nmap -sT 127.0.0.1 -p $NEO4J_HTTP_PORT
nmap -sT 127.0.0.1 -p $NEO4J_BOLT_PORT
