// Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved. // SPDX-License-Identifier: CC-BY-SA-4.0

# Introduction

This project stores instructions to bring up MySQL database on AWS RDS.

- [Introduction](#introduction)
  - [Installation](#installation)
    - [Launch database](#launch-database)
    - [IAM policy](#iam-policy)
  - [Clean-up](#clean-up)
    - [Database objects](#database-objects)
    - [RDS instance and IAM policy](#rds-instance-and-iam-policy)

## Installation

Installation of the AWS RDS (MySQL) database is a two step process as described below.

### Launch database

Create the database and its objects with the following commands.

```bash
git clone ${GIT_URL}/eks-saga-db

export PROJECT_HOME=${PWD}/eks-saga-db
# Change this password !!
export MYSQL_MASTER_PASSWORD='V3ry.Secure.Passw0rd'
export RDS_DB_ID=eks-saga-db

source ${PROJECT_HOME}/scripts/db.sh
source ${PROJECT_HOME}/scripts/ddl.sh
```

### IAM policy

Create IAM policy for connecting to the database by following the commands below.

```bash
cd eks-saga-db/scripts
export RDS_DB_ID=eks-saga-db
export DB_RESOURCE_ID=`aws rds describe-db-instances --db-instance-identifier ${RDS_DB_ID} --query 'DBInstances[0].DbiResourceId' --output text`
./iam.sh ${REGION_ID} ${ACCOUNT_ID} ${DB_RESOURCE_ID}
```

## Clean-up

Clean up of the AWS RDS (MySQL) database is a two step process as described below.

### Database objects

1. Follow the steps below, to remove the database objects.

```bash
git clone ${GIT_URL}/eks-saga-db

export PROJECT_HOME=${PWD}/eks-saga-db
# Use changed password !!
export MYSQL_MASTER_PASSWORD='V3ry.Secure.Passw0rd'
export RDS_DB_ID=eks-saga-db

source ${PROJECT_HOME}/scripts/drop.sh
```

### RDS instance and IAM policy

1. To remove the RDS instance and IAM policy use the commands below.

```bash
export PROJECT_HOME=${PWD}/eks-saga-db
export RDS_DB_ID=eks-saga-db
source ${PROJECT_HOME}/scripts/cleanup.sh ${ACCOUNT_ID} ${RDS_DB_ID}
``` 
