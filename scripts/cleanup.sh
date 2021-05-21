#!/bin/bash

set -e

cleanUp() {
  ACCOUNT_ID=$1
  RDS_DB_ID=$2
  GROUP_NAME=$3
  
  echo 'Removing RDS DB instance'
  aws rds delete-db-instance --db-instance-identifier ${RDS_DB_ID} --skip-final-snapshot --query 'DBInstance.DBInstanceIdentifier' --output text 

  DB_STATUS='true'
  while [[ "${DB_STATUS}" == 'true' ]]
  do
    if `aws rds describe-db-instances --db-instance-identifier ${RDS_DB_ID} 1>/dev/null 2>/dev/null`;
    then
      DB_STATUS='true'
      echo 'Deleting.'
    else
      DB_STATUS='false'
      echo 'Deleted.'
    fi
    sleep 10
  done
  echo 'Removed database'
}

if [[ $# -ne 2 ]] ; then
  echo 'USAGE: ./cleanup.sh accountId rdsDb'
  exit 1
fi

ACCOUNT_ID=$1
RDS_DB_ID=$2
GROUP_NAME="eks-saga-orchestration-sg"

cleanUp ${ACCOUNT_ID} ${RDS_DB_ID} ${GROUP_NAME}