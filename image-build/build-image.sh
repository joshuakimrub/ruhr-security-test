#!/bin/bash

source ../deployment/variables.sh

# create resource group if it does not exist
GROUP_EXISTS=$(az group exists -n $RESOURCE_GROUP)
if [ $GROUP_EXISTS != "true"]
then
    az group create -n $RESOURCE_GROUP -l $LOCATION
fi

packer init .
packer build \
    -var "client_secret=$CLIENT_SECRET" \
    -var "client_id=$CLIENT_ID" \
    -var "tenant_id=$TENANT_ID" \
    -var "subscription_id=$SUBSCRIPTION_ID" \
    -var "resource_group=$RESOURCE_GROUP" \
    -var "image_name=$IMAGE" \
    -var "location=$LOCATION" \
    hardened-ubuntu.pkr.hcl
