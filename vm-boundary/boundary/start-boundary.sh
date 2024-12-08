#!/bin/bash

source ../../deployment/variables.sh

AES_KEY=$(az keyvault secret show --vault-name task-vault --name KmsAesKey --query value -o tsv)
POSTGRES_PASSWORD=$(az keyvault secret show --vault-name task-vault --name BoundaryPostgresPassword --query value -o tsv)

CERT_PATH=${CERT_FOLDER}/${SERVER_NAME}.crt
KEY_PATH=${CERT_FOLDER}/${SERVER_NAME}.key

sed "s/\${CERT}/$CERT_PATH/g" boundary.hcl
sed "s/\${KEY}/$KEY_PATH/g" boundary.hcl
sed "s/\${POSTGRES_PASSWORD}/$POSTGRES_PASSWORD/g" boundary.hcl
sed "s/\${AES_KEY}/$AES_KEY/g" boundary.hcl

boundary server -config boundary.hcl

sed "s/$CERT_PATH/\${CERT}/g" boundary.hcl
sed "s/$KEY_PATH/\${KEY}/g" boundary.hcl
sed "s/$POSTGRES_PASSWORD/\${POSTGRES_PASSWORD}/g" boundary.hcl
sed "s/$AES_KEY/\${AES_KEY}/g" boundary.hcl
