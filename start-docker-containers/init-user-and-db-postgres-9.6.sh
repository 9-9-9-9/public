#!/bin/bash

source ./my-env.sh

echo 'Setup postgres client'
sudo yum install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm
sudo yum install -y postgresql96

PGPASSWORD=$POSTGRES_PWD psql \
	--host=127.0.0.1 --port=5432 \
	--username=postgres \
	--command="REVOKE ALL ON DATABASE postgres FROM PUBLIC;"

PGPASSWORD=$POSTGRES_PWD createdb \
	--host=127.0.0.1 --port=5432 \
	--username=postgres \
	$POSTGRES_DB_SALES_STRUCTURE

PGPASSWORD=$POSTGRES_PWD psql \
	--host=127.0.0.1 --port=5432 \
	--username=postgres \
	--command="CREATE USER $POSTGRES_USER_SALES_STRUCTURE WITH PASSWORD '$POSTGRES_USERPASS_SALES_STRUCTURE';"
