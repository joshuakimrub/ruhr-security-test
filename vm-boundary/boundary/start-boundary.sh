#!/bin/bash

source ../../deployment/variables.sh

AES_KEY=$(az keyvault secret show --vault-name task-vault --name KmsAesKey --query value -o tsv)
POSTGRES_PASSWORD=$(az keyvault secret show --vault-name task-vault --name BoundaryPostgresPassword --query value -o tsv)

CERT_PATH=${CERT_FOLDER}${SERVER_NAME}.crt
KEY_PATH=${CERT_FOLDER}${SERVER_NAME}.key

mkdir postgres-data
# start postgres DB for boundary
docker run \
  --rm \
  --name boundaryPostgres \
  -v ./postgres-data:/var/lib/postgresql/data \
  -p 5432:5432 \
  -e POSTGRES_PASSWORD="$POSTGRES_PASSWORD" \
  -e POSTGRES_DB="boundary" \
  -d \
  postgres

# start boundary

sed -i "s|\${CERT}|$CERT_PATH|g" boundary.hcl
sed -i "s|\${KEY}|$KEY_PATH|g" boundary.hcl
sed -i "s|\${POSTGRES_PASSWORD}|$POSTGRES_PASSWORD|g" boundary.hcl
sed -i "s|\${AES_KEY}|$AES_KEY|g" boundary.hcl

boundary server -config boundary.hcl

sed -i "s|$CERT_PATH|\${CERT}|g" boundary.hcl
sed -i "s|$KEY_PATH|\${KEY}|g" boundary.hcl
sed -i "s|$POSTGRES_PASSWORD|\${POSTGRES_PASSWORD}|g" boundary.hcl
sed -i "s|$AES_KEY|\${AES_KEY}|g" boundary.hcl
