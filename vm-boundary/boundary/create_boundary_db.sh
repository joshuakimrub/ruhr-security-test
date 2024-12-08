#!/bin/bash

POSTGRES_PASSWORD=$(az keyvault secret show --vault-name task-vault --name BoundaryPostgresPassword --query value -o tsv)

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
