#!/bin/bash

set -e

echo "Creating database ${RDS_DB_ID}"
aws rds create-db-instance --db-name ekssagadb \
  --db-instance-identifier ${RDS_DB_ID} \
  --db-instance-class db.t2.micro \
  --allocated-storage 20 \
  --engine mysql \
  --master-username admin \
  --master-user-password ${MYSQL_MASTER_PASSWORD} \
  --publicly-accessible \
  --enable-iam-database-authentication --output text

DB_STATUS=`aws rds describe-db-instances --db-instance-identifier ${RDS_DB_ID} --query 'DBInstances[0].DBInstanceStatus' --output text`
echo 'Database status: ' ${DB_STATUS}

while [[ ${DB_STATUS} != 'available' ]]
do
  sleep 10
  DB_STATUS=`aws rds describe-db-instances --db-instance-identifier ${RDS_DB_ID} --query 'DBInstances[0].DBInstanceStatus' --output text`
  echo 'Database status: ' ${DB_STATUS}
done
