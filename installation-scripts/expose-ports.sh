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
	# Angular
	expose 4200
	
	# Elastic Search
	expose 9200
	expose 9300
	
	# Neo4J
	expose 7474
	expose 7687
	
	# PostgreSQL
	expose 5432
	
	firewall-cmd --reload
elif
	echo 'Can not find public zone'
	exit 1
fi
