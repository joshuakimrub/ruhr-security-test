#!/bin/bash

source ../../deployment/variables.sh

export AES_KEY=$(az keyvault secret show --vault-name task-vault --name KmsAes --query value -o tsv)
export POSTGRES_PASSWORD=$(az keyvault secret show --vault-name task-vault --name BoundaryPostgresPassword --query value -o tsv)

boundary server -config boundary.hcl
