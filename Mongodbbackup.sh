#!/bin/bash 
export PATH=/bin:/usr/bin:/usr/local/bin 
TODAY=`date +"%d%b%Y"` 
DB_BACKUP_PATH='/root/backup/' 
MONGO_HOST='localhost' 
MONGO_PORT='27017' 
# If mongodb is protected with username password. 
# Set AUTH_ENABLED to 1 
# and add MONGO_USER and MONGO_PASSWD values correctly 
AUTH_ENABLED=1 
MONGO_USER='user' 
MONGO_PASSWD='admin' 
# Set DATABASE_NAMES to "ALL" to backup all databases. 
# or specify databases names seprated with space to backup 
# specific databases only.
DATABASE_NAMES='ALL'
DATABASE_NAMES='nokia' 
#DATABASE_NAMES='mydb db2 newdb' 
mkdir -p ${DB_BACKUP_PATH}/${TODAY} 
AUTH_PARAM="" 
if [ ${AUTH_ENABLED} -eq 1 ]; then 
 AUTH_PARAM=" --username ${MONGO_USER} --password ${MONGO_PASSWD} --authenticaionDatabase admin" 
fi 
if [ ${DATABASE_NAMES} = "ALL" ]; then 
echo "You have choose to backup all databases" 
mongodump --host ${MONGO_HOST} --port ${MONGO_PORT} ${AUTH_PARAM} --out ${DB_BACKUP_PATH}/${TODAY}/ 
else 
echo "Running backup for selected databases" 
for DB_NAME in ${DATABASE_NAMES} 
do 
mongodump --host ${MONGO_HOST} --port ${MONGO_PORT} --db ${DB_NAME} ${AUTH_PARAM} --out ${DB_BACKUP_PATH}/${TODAY}/ 
 done 
fi
