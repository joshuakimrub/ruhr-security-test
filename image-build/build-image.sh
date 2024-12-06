#!/bin/bash

CLIENT_SECRET=$(az keyvault secret show --vault-name task-vault --name ClientSecret --query value -o tsv)
CLIENT_ID='7186b5c0-9e6a-4637-89f0-2c67144ebe20'
TENANT_ID='dc90e60f-fd1e-40a6-81c5-903cb3cc6a92'
SUBSCRIPTION_ID='eda1bd7d-0cd7-41eb-92dd-aa84171f2820'

packer init .
packer build -var "client_secret=$CLIENT_SECRET" -var "client_id=$CLIENT_ID" -var "tenant_id=$TENANT_ID" -var "subscription_id=$SUBSCRIPTION_ID" hardened-ubuntu.pkr.hcl
