#!/bin/bash

source ./my-env.sh

echo 'Setup postgres client'
sudo yum install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm
sudo yum install -y postgresql96

PGPASSWORD=$POSTGRES_PWD psql --host=127.0.0.1 --port=5432 --username=postgres
