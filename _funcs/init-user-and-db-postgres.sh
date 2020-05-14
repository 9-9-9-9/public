#!/bin/bash

if [ -z "$ENV_IS_LOADED_BY_MYENV" ]
then
	echo 'Missing env from my-env.sh'
	exit 1
fi

echo 'Setup postgres client'
sudo yum install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm
sudo yum install -y postgresql96

# Create database
PGPASSWORD=$POSTGRES_PWD createdb \
	--host=127.0.0.1 --port=5432 \
	--username=postgres \
	$POSTGRES_DB_SALES_STRUCTURE

# Revoke permissions on new database from any PUBLIC
PGPASSWORD=$POSTGRES_PWD psql \
	--host=127.0.0.1 --port=5432 \
	--username=postgres \
	--command="REVOKE ALL ON DATABASE $POSTGRES_DB_SALES_STRUCTURE FROM PUBLIC;"

# Revoke permissions on default database from any PUBLIC
PGPASSWORD=$POSTGRES_PWD psql \
	--host=127.0.0.1 --port=5432 \
	--username=postgres \
	--command="REVOKE ALL ON DATABASE postgres FROM PUBLIC;"

# Create user
PGPASSWORD=$POSTGRES_PWD psql \
	--host=127.0.0.1 --port=5432 \
	--username=postgres \
	--command="CREATE USER $POSTGRES_USER_SALES_STRUCTURE WITH PASSWORD '$POSTGRES_USERPASS_SALES_STRUCTURE';"

# Grant permission on new database to above user
PGPASSWORD=$POSTGRES_PWD psql \
	--host=127.0.0.1 --port=5432 \
	--username=postgres \
	--command="GRANT ALL ON DATABASE $POSTGRES_DB_SALES_STRUCTURE TO $POSTGRES_USER_SALES_STRUCTURE;"
