#!/bin/bash

#COLORSITOS

Color_Off='\033[0m'
Cyan='\033[0;36m'
Verde='\033[0;32m'
echo -e "$Cyan \n Actualizando Sistema Operativo.. $Color_Off"
sudo apt-get update -y && sudo apt-get upgrade -y

echo -e "$Cyan \n Instalando Apache2.. $Color_Off"
sudo apt-get install apache2 apache2-doc apache2-utils -y

echo -e "$Cyan \n Instalando PHP y Requerimientos $Color_Off"
sudo apt-get install libapache2-mod-php php-common php-curl php-dev php-gd php-pear php-imagick php-xml php-mbstring php-cli -y

echo -e "$Cyan \n Otorgando permisos para /var/www $Color_Off"
sudo chown -R www-data:www-data /var/www

echo -e "$Verde \n Permisos cambiados $Color_Off"

echo -e "$Cyan \n Habilitando módulos $Color_Off"
sudo a2enmod rewrite
sudo a2enmod authnz_ldap

echo -e "$Cyan \n Reiniciando Apache $Color_Off"
sudo service apache2 restart