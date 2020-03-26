#! /bin/bash

#COLORSITOS

Color_Off='\033[0m'
Cyan='\033[0;36m'
Verde='\033[0;32m'
Rojo='\033[0;31m'

echo -e "$Cyan \n Actualizando Sistema Operativo.. $Color_Off"
sudo apt update -y 
sudo apt upgrade -y 

#INSTALAR SUDO
echo -e "$Cyan \n Instalando sudo.. $Color_Off"
apt install -y sudo 		
#INSTALAR CURL
echo -e "$Cyan \n Instalando curl.. $Color_Off"
sudo apt-get install -y curl 
#INSTALAR GIT
echo -e "$Cyan \n Instalando git.. $Color_Off"
sudo apt install -y git
#INSTALAR PHP
echo -e "$Cyan \n Instalando php.. $Color_Off"
sudo apt install -y php5 
#INSTALAR COMPOSER
echo -e "$Cyan \n Instalando composer.. $Color_Off"
curl -sS https://getcomposer.org/installer | php >> bitacora.log 2>&1
mv composer.phar /usr/local/bin/composer >> bitacora.log 2>&1
ln -s /usr/local/bin/composer /usr/bin/composer >> bitacora.log 2>&1
#INSTALAR DRUSH
echo -e "$Cyan \n Instalando drush.. $Color_Off"
git clone https://github.com/drush-ops/drush.git /usr/local/src/drush >> bitacora.log 2>&1
cd /usr/local/src/drush >> bitacora.log 2>&1
git checkout 7.0.0-alpha5 >> bitacora.log 2>&1
ln -s /usr/local/src/drush/drush /usr/bin/drush >> bitacora.log 2>&1
composer install >> bitacora.log 2>&1
#INSTALAR DRUPAL 8
echo -e "$Cyan \n Instalando drupal.. $Color_Off"
drush dl drupal-7.69 >> bitacora.log 2>&1
mv drupal-7.69 /var/www/sitio1 >> bitacora.log 2>&1
drush dl drupal-7.69 >> bitacora.log 2>&1
mv drupal-7.69 /var/www/sitio2 >> bitacora.log 2>&1
echo -e "$Verde \n Sitios instalados en /var/www/sitio1 y /var/www/sitio2 $Color_Off"

		
