#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root. Use sudo to execute the script."
   exit 1
fi

echo "Setting up UFW rules..."

ufw status | grep -q "inactive"
if [ $? -eq 0 ]; then
    echo "UFW is inactive. Enabling UFW..."
    ufw --force enable
fi

echo "Allowing SSH on port 22..."
ufw allow 22/tcp

echo "Allowing port 9200 for subnet 172.20.0.0/16..."
ufw allow from 172.20.0.0/16 to any port 9200

echo "Allowing port 9202 from anywhere..."
ufw allow 9202

echo "Reloading UFW to apply changes..."
ufw reload

echo "Final UFW rules:"
ufw status verbose
