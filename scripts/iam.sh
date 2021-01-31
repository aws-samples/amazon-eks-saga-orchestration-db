#!/bin/bash

set -e

i_setup() {
  REGION_ID=$1
  ACCOUNT_ID=$2
  DB_RESOURCE_ID=$3

  JSON_DIR=../json
  cd ${JSON_DIR}

  sed -e 's/regionId/'"${REGION_ID}"'/g' -e 's/accountId/'"${ACCOUNT_ID}"'/g' -e 's/dbResourceId/'"${DB_RESOURCE_ID}"'/g' eks-saga-rds-iam-policy.json > eks-saga-rds-iam-policy.json.policy
  POLICY_ARN=`aws iam create-policy --policy-name eks-saga-rds-policy --policy-document file://eks-saga-rds-iam-policy.json.policy --query 'Policy.Arn' --output text`
  echo "RDS Policy ARN: ${POLICY_ARN}"

  rm eks-saga-rds-iam-policy.json.policy
}

if [[ $# -ne 3 ]] ; then
  echo 'USAGE: ./iam.sh regionId accountId resourceId'
  exit 1
fi

REGION_ID=$1
ACCOUNT_ID=$2
RESOURCE_ID=$3

i_setup ${REGION_ID} ${ACCOUNT_ID} ${RESOURCE_ID}