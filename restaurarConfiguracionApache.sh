#!/bin/bash

#COLORSITOS

Color_Off='\033[0m'
Verde='\033[0;32m'

tar -xvzf configuracionApache.tar.gz 

mv .htaccess1 /var/www/drupal1/.htaccess
mv .htaccess2 /var/www/drupal2/.htaccess

mv drupal1.conf /etc/apache2/sites-available
mv drupal2.conf /etc/apache2/sites-available

a2ensite drupal1.conf
a2ensite drupal2.conf

mv apache2.conf /etc/apache2/
mv security.conf /etc/apache2/conf-available

mv drupal.crt /etc/ssl/certs/
mv drupal.key /etc/ssl/private

systemctl restart apache2

echo -e "$Verde \n Configuración de Apache restablecida $Color_Off"




