#!/bin/bash

if [ "$EUID" -ne 0 ]
then 
	echo "Please run with sudo"
	exit 1
fi

expose() {
	firewall-cmd --zone=public --add-port=$1/tcp --permanent
}

if [[ "$(firewall-cmd --get-active-zones | grep public)" =~ 'public' ]]
then
	# Elastic Search
	expose 9200
	expose 9300
	
	# Neo4J
	expose 7474
	expose 7687
	
	# PostgreSQL
	expose 5432

	# Cassandra
	expose 9042

	# Kong
	expose 8000
	expose 8443
	expose 8001
	expose 8444

	# Kafka
	#  itself
	expose 9092
	#  zookeeper
	expose 2181
	expose 2888
	expose 3888

	# Angular
	expose 4200
	
	firewall-cmd --reload
else
	echo 'Can not find public zone'
	exit 1
fi
