#! /bin/bash
source $SECRETS_KEYS
echo "dppass: $DB_PASS"
docker stop dp_db_cfgsvc
docker rm dp_db_cfgsvc
docker stop cwcget
docker rm cwcwget
docker stop localdb
docker rm localdb



echo "------------------------------list of available user---------------------------------"
awk -F':' '{ print $1}' /etc/passwd
echo "-----------------------------------------------------------------------------------------"
if [[ -n "$DB_PASS" ]]; then echo "The password is $DB_PASS"; else  export DB_PASS="pguser123"; fi
docker run -d --restart=always -p 5432:5432 -e POSTGRES_PASSWORD=$DB_PASS -e POSTGRES_DB=mpsdb -e  POSTGRES_USER=mpsroot --name dp_db_cfgsvc  postgres
