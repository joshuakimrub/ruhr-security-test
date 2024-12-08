#!/bin/bash

# Service principal shall be created manually
CLIENT_SECRET=$(az keyvault secret show --vault-name task-vault --name ClientSecret --query value -o tsv)
CLIENT_ID='7186b5c0-9e6a-4637-89f0-2c67144ebe20'
TENANT_ID='dc90e60f-fd1e-40a6-81c5-903cb3cc6a92'
SUBSCRIPTION_ID='eda1bd7d-0cd7-41eb-92dd-aa84171f2820'
RESOURCE_GROUP="ruhr-security-task"
VM_NAME="hardened-vm"
IMAGE="hardened-ubuntu-2204-no-azure"
ADMIN_NAME="azadmin"
SHH_PUB_KEY="/home/kim/.ssh/id_ed25519.pub"
LOCATION="germanywestcentral"

CA_NAME="JK-CA"
SERVER_NAME="VM"