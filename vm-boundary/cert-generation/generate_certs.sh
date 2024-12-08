#!/bin/bash

source ../../deployment/variables.sh
# Generate CA key and certificate

openssl genrsa -out $CA_NAME.key 4096
openssl req -x509 -new -nodes -key $CA_NAME.key \
            -sha256 -days 365 -out $CA_NAME.crt \
            -subj '/CN=Self-Signed Root CA'

# Create server certificate and key
openssl genrsa -out $SERVER_NAME.key 4096
openssl req -new -key $SERVER_NAME.key -out $SERVER_NAME.csr -config server.cnf -extensions v3_req
openssl x509 -req -in $SERVER_NAME.csr -CA $CA_NAME.crt \
             -CAkey $CA_NAME.key \
             -CAcreateserial -out $SERVER_NAME.crt -days 365 -sha256 \
             -extfile server.cnf -extensions v3_req

sudo mkdir $CERT_FOLDER
sudo mv $SERVER_NAME.crt $SERVER_NAME.key $CA_NAME.crt $CA_NAME.key $CERT_FOLDER
