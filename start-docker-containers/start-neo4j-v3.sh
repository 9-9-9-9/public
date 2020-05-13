#!/bin/bash

source ./my-env.sh

export NEO4J_HTTP_PORT=7474
export NEO4J_BOLT_PORT=7687

docker run \
	--name $CONTAINER_NEO4J_3_NAME \
	--restart unless-stopped \
	-d \
	-p $NEO4J_HTTP_PORT:$NEO4J_HTTP_PORT \
	-p $NEO4J_BOLT_PORT:$NEO4J_BOLT_PORT \
	-v neo4j-v3:/data \
	-v conf-neo4j-v3:/conf \
	-v logs-neo4j-v3:/logs \
	-e NEO4J_AUTH=$NEO4J_USERNAME/$NEO4J_PWD \
	-e NEO4J_dbms_security_procedures_unrestricted=apoc.* \
	-e NEO4J_apoc_import_file_enabled=true \
	-e NEO4J_apoc_export_file_enabled=true \
	neo4j:$DOCKER_IMG_NEO4J_V3

echo 'Waiting container (5s)'
sleep 5

echo 'Copying neo4j.conf from (default) /var/lib/neo4j/conf/neo4j.conf to /conf/neo4j.conf'
#docker exec -it $CONTAINER_NEO4J_3_NAME cp /var/lib/neo4j/conf/neo4j.conf /conf
#docker exec -it $CONTAINER_NEO4J_3_NAME echo -e '\ndbms.active_database=sales_structure.db' /conf/neo4j.conf


docker restart $CONTAINER_NEO4J_3_NAME

sleep 2

nmap -sT 127.0.0.1 -p $NEO4J_HTTP_PORT
nmap -sT 127.0.0.1 -p $NEO4J_BOLT_PORT
