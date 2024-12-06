#!/bin/bash

source ./variables.sh

az vm create \
    --resource-group $RESOURCE_GROUP \
    --name $VM_NAME \
    --image $IMAGE \
    --admin-username $ADMIN_NAME \
    --ssh-key-value "$SHH_PUB_KEY" \
    --enable-agent false
