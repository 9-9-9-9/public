#!/bin/bash

echo 'Loading shared env'

# Tags
export DOCKER_IMG_NEO4J_V3=3.5.17
export DOCKER_IMG_NEO4J_V4=4.0.4

export DOCKER_IMG_POSTGRES_V9=9.6

export DOCKER_IMG_ELASTICSEARCH_V6=6.8.9

export DOCKER_IMG_CASSANDRA_V3=3.11.6

export DOCKER_IMG_KONG_V2=2.0.4-ubuntu

# Custom PostgreSQL

export POSTGRES_PWD=1234567

export CONTAINER_POSTGRES_9_NAME=postgres

export POSTGRES_DB_SALES_STRUCTURE=sales_structure
export POSTGRES_USER_SALES_STRUCTURE=sales_structure
export POSTGRES_USERPASS_SALES_STRUCTURE=1234567

# Custom Neo4J
export NEO4J_USERNAME=neo4j
export NEO4J_PWD=1234567
export CONTAINER_NEO4J_3_NAME=neo4j

# Custom Elastic Search
export CONTAINER_ELASTIC_6_NAME=elastic

# Others
export ENV_IS_LOADED_BY_MYENV='yes'
