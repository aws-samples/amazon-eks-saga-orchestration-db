#!/bin/bash

set -e

run_ddl() {
  DB_ENDPOINT=`aws rds describe-db-instances --db-instance-identifier ${RDS_DB_ID} --query 'DBInstances[0].Endpoint.Address' --output text`
  
  DB_SG=`aws rds describe-db-instances --db-instance-identifier ${RDS_DB_ID} --query 'DBInstances[0].VpcSecurityGroups[0].VpcSecurityGroupId' --output text`
  MY_IP=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
  aws ec2 authorize-security-group-ingress --group-id ${DB_SG} --protocol tcp --port 3306 --cidr ${MY_IP}/32
  echo "Opened database port for this - ${MY_IP} - IP address"

  echo 'Dropping tables'
  export MYSQL_PWD=${MYSQL_MASTER_PASSWORD}
  mysql -h ${DB_ENDPOINT} -P 3306 -u admin < ${PROJECT_HOME}/ddl/drop.sql
  aws ec2 revoke-security-group-ingress --group-id ${DB_SG} --protocol tcp --port 3306 --cidr ${MY_IP}/32
  echo "Closed database port for this - ${MY_IP} - IP address"
}

run_ddl