#!/bin/bash

echo 'Loading shared env'

export POSTGRES_PWD=1234567

export NEO4J_USERNAME=neo4j
export NEO4J_PWD=1234567

export CONTAINER_POSTGRES_9_NAME=postgres-v9
export 	CONTAINER_NEO4J_3_NAME=neo4j

# Tags
export DOCKER_IMG_NEO4J_V3=3.5.17

# Custom
export POSTGRES_DB_SALES_STRUCTURE=sales_structure
export POSTGRES_USER_SALES_STRUCTURE=sales_structure
export POSTGRES_USERPASS_SALES_STRUCTURE=1234567
