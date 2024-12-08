#!/bin/bash

sudo a2enmod ssl
sudo a2enmod headers

sudo cp ./localhost-ssl.conf /etc/apache2/sites-available/
sudo a2ensite localhost-ssl.conf
sudo a2dissite 000-default.conf
sudo a2dissite default-ssl.conf
sudo cp ./ports.conf /etc/apache2/
sudo systemctl restart apache2