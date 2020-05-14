#!/bin/bash

source ../_funcs/my-env.sh

# Pull images
echo 'Pulling neo4j images'
docker pull neo4j:$DOCKER_IMG_NEO4J_V4
docker pull neo4j:$DOCKER_IMG_NEO4J_V3

echo 'Pulling postgres images'
docker pull postgres:$DOCKER_IMG_POSTGRES_V9

echo 'Pulling elasticsearch images'
docker pull elasticsearch:$DOCKER_IMG_ELASTICSEARCH_V6

echo 'Pulling cassandra images'
docker pull cassandra:$DOCKER_IMG_CASSANDRA_V3

echo 'Pulling kong images'
docker pull kong:$DOCKER_IMG_KONG_V2

# Install additional tools
sudo yum install nmap -y

echo 'Pull-Done'
