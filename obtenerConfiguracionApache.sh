#!/bin/bash

#COLORSITOS

Color_Off='\033[0m'
Verde='\033[0;32m'

cp /var/www/drupal1/.htaccess ./.htaccess1
cp /var/www/drupal2/.htaccess ./.htaccess2

cp /etc/apache2/sites-available/drupal1.conf .
cp /etc/apache2/sites-available/drupal2.conf .

cp /etc/apache2/apache2.conf .
cp /etc/apache2/conf-available/security.conf .

cp /etc/ssl/certs/drupal.crt .
cp /etc/ssl/private/drupal.key .

tar -czvf configuracionApache.tar.gz .htaccess1 .htaccess2 drupal1.conf drupal2.conf apache2.conf security.conf drupal.crt drupal.key

if [ $? -ne 0 ]; then
	echo "Error: verifique sus permisos"
	if [ -e configuracionApache.tar.gz ]; then
		rm configuracionApache.tar.gz
	fi 
else
	rm .htaccess1 .htaccess2 drupal1.conf drupal2.conf security.conf apache2.conf drupal.crt drupal.key

	echo -e "$Verde \n Configuración de Apache obtenida $Color_Off"
fi


