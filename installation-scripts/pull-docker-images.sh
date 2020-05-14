#!/bin/bash

../_func/my-env.sh

# Pull images
echo 'Pulling neo4j images'
docker pull neo4j:$DOCKER_IMG_NEO4J_V4
docker pull neo4j:$DOCKER_IMG_NEO4J_V3

echo 'Pulling postgres images'
docker pull postgres:$DOCKER_IMG_POSTGRES_V9

# Install additional tools
sudo yum install nmap -y

echo 'Pull-Done'
