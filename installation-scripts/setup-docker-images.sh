#!/bin/bash

# Pull images
echo 'Pulling neo4j images'
#docker pull neo4j:4.0.4
#docker pull neo4j:3.5.3
docker pull neo4j:3.5.17

echo 'Pulling postgres images'
#docker pull postgres:12.2
#docker pull postgres:11.7
#docker pull postgres:10.12
docker pull postgres:9.6

# Install additional tools
sudo yum install nmap -y

echo 'Done, now you can use start-xxx.sh script to start containers'
