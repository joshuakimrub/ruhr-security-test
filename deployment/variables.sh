#!/bin/bash

# Service principal shall be created manually
export CLIENT_SECRET=$(az keyvault secret show --vault-name task-vault --name ClientSecret --query value -o tsv)
export CLIENT_ID='7186b5c0-9e6a-4637-89f0-2c67144ebe20'
export TENANT_ID='dc90e60f-fd1e-40a6-81c5-903cb3cc6a92'
export SUBSCRIPTION_ID='eda1bd7d-0cd7-41eb-92dd-aa84171f2820'
export RESOURCE_GROUP="ruhr-security-task"
export VM_NAME="hardened-vm"
export IMAGE="hardened-ubuntu-2204-no-azure"
export ADMIN_NAME="azadmin"
export SHH_PUB_KEY="/home/kim/.ssh/id_ed25519.pub"
export LOCATION="germanywestcentral"
export 
export CA_NAME="JK-CA"
export SERVER_NAME="VM"
export CERT_FOLDER=/etc/certs/