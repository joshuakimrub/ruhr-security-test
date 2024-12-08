#!/bin/bash

source ../../deployment/variables.sh

AES_KEY=$(az keyvault secret show --vault-name task-vault --name KmsAesKey --query value -o tsv)
POSTGRES_PASSWORD=$(az keyvault secret show --vault-name task-vault --name BoundaryPostgresPassword --query value -o tsv)

CERT_PATH=${CERT_FOLDER}${SERVER_NAME}.crt
KEY_PATH=${CERT_FOLDER}${SERVER_NAME}.key

mkdir postgres-data
# start postgres DB for boundary (reverse engineered command from boundary dev)
docker run \
  --rm \
  --name boundaryPostgres \
  -v ./postgres-data:/var/lib/postgresql/data \
  --name "/exciting_margulis" \
  --runtime "runc" \
  --publish-all \
  --log-driver "json-file" \
  --restart "no" \
  --publish "0.0.0.0:32772:5432/tcp" \
  --network "bridge" \
  --hostname "c7b08c864202" \
  --expose "5432/tcp" \
  --env "POSTGRES_PASSWORD=$POSTGRES_PASSWORD" \
  --env "POSTGRES_DB=boundary" \
  --env "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/lib/postgresql/12/bin" \
  --env "GOSU_VERSION=1.17" \
  --env "LANG=en_US.utf8" \
  --env "PG_MAJOR=12" \
  --env "PG_VERSION=12.22-1.pgdg120+1" \
  --env "PGDATA=/var/lib/postgresql/data" \
  --detach \
  --entrypoint "docker-entrypoint.sh" \
  "postgres:12" \
  "-c" "jit=off"

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
