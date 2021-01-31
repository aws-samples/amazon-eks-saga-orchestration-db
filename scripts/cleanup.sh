#!/bin/bash

set -e

cleanUp() {
  ACCOUNT_ID=$1
  RDS_DB_ID=$2

  echo 'Removing RDS policy'
  aws iam delete-policy --policy-arn arn:aws:iam::${ACCOUNT_ID}:policy/eks-saga-rds-policy
  
  echo 'Removing RDS DB instance'
  aws rds delete-db-instance --db-instance-identifier ${RDS_DB_ID} --skip-final-snapshot
  DB_STATUS=`aws rds describe-db-instances --db-instance-identifier ${RDS_DB_ID} --query 'DBInstances[0].DBInstanceStatus' --output text`
  echo 'Database status: ' ${DB_STATUS}

  aws rds describe-db-instances --db-instance-identifier ${RDS_DB_ID} 1> /dev/null 2> /dev/null
  DB_DESCRIBE_RC=`echo $?`

  while [[ ${DB_DESCRIBE_RC} == 0 ]]
  do
    sleep 10
    aws rds describe-db-instances --db-instance-identifier ${RDS_DB_ID} 1> /dev/null 2> /dev/null
    DB_DESCRIBE_RC=`echo $?`
  done

  echo 'Database deleted.'
}

if [[ $# -ne 2 ]] ; then
  echo 'USAGE: ./cleanup.sh accountId rdsDb'
  exit 1
fi

ACCOUNT_ID=$1
RDS_DB_ID=$2

cleanUp ${ACCOUNT_ID} ${RDS_DB_ID}
