#!/bin/bash

if [[ "$1" == "--deploy" ]]; then
  DEPLOY=true
else
  DEPLOY=false
fi

source ../../deployment/variables.sh

AES_KEY=$(az keyvault secret show --vault-name task-vault --name KmsAesKey --query value -o tsv)
POSTGRES_PASSWORD=$(az keyvault secret show --vault-name task-vault --name BoundaryPostgresPassword --query value -o tsv)

CERT_PATH=${CERT_FOLDER}${SERVER_NAME}.crt
KEY_PATH=${CERT_FOLDER}${SERVER_NAME}.key

# setup boundary to execute mlock without running as root
sudo setcap cap_ipc_lock=+ep $(readlink -f $(which boundary))

# start boundary

sed -i "s|\${CERT}|$CERT_PATH|g" boundary.hcl
sed -i "s|\${KEY}|$KEY_PATH|g" boundary.hcl
sed -i "s|\${POSTGRES_PASSWORD}|$POSTGRES_PASSWORD|g" boundary.hcl
sed -i "s|\${AES_KEY}|$AES_KEY|g" boundary.hcl

boundary database init -config boundary.hcl

if [ "$DEPLOY" = true ] ; then
    sudo mv /etc/boundary.d/boundary.hcl /etc/boundary.d/boundary.hcl.old
    sudo cp ./boundary.hcl /etc/boundary.d/boundary.hcl
else
    boundary server -config boundary.hcl
fi

sed -i "s|$CERT_PATH|\${CERT}|g" boundary.hcl
sed -i "s|$KEY_PATH|\${KEY}|g" boundary.hcl
sed -i "s|$POSTGRES_PASSWORD|\${POSTGRES_PASSWORD}|g" boundary.hcl
sed -i "s|$AES_KEY|\${AES_KEY}|g" boundary.hcl
