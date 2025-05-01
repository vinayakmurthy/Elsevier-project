#!/bin/bash
apt update
apt install apache2 wget unzip -y
systemctl start apache2
systemctle enable apache2

wget https://www.tooplate.com/zip-templates/2129_crispy_kitchen.zip
unzip -o 2129_crispy_kitchen.zip
cp -r 2129_crispy_kitchen/* /var/www/html/
systemctl restart apache2