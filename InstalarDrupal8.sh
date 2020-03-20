#! /bin/bash

#COLORSITOS

Color_Off='\033[0m'
Cyan='\033[0;36m'
Verde='\033[0;32m'

echo -e "$Cyan \n Actualizando sistema.. $Color_Off"
sudo apt -y update && apt -y upgrade
#INSTALAR CURL
echo -e "$Cyan \n Instalando curl.. $Color_Off"
sudo apt install -y curl
#INSTALAR GIT
echo -e "$Cyan \n Instalando git.. $Color_Off"
sudo apt install -y git
#INSTALAR PHP
echo -e "$Cyan \n Instalando php.. $Color_Off"
sudo apt install -y php php-xml php-fpm php-pgsql libapache2-mod-php php-mbstring
#INSTALAR POSTGRES
echo -e "$Cyan \n Instalando cliente de postgres.. $Color_Off"
sudo apt install -y postgresql-11 postgresql-client-11
#INSTALAR COMPOSER
echo -e "$Cyan \n Instalando composer.. $Color_Off"
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
ln -s /usr/local/bin/composer /usr/bin/composer
#INSTALAR DRUSH
echo -e "$Cyan \n Instalando drush.. $Color_Off"
git clone https://github.com/drush-ops/drush.git /usr/local/src/drush
cd /usr/local/src/drush
git checkout 7.0.0-alpha5
ln -s /usr/local/src/drush/drush /usr/bin/drush
composer install
#INSTALAR DRUPAL 8
echo -e "$Cyan \n Instalando drupal.. $Color_Off"
drush dl drupal-8.8.4
mv /usr/local/src/drush/drupal-8.8.4 /var/www/drupal1
drush dl drupal-8.8.4
mv /usr/local/src/drush/drupal-8.8.4 /var/www/drupal2

echo -e "$Verde \n Sitios instalados en /var/www/drupal1 y /var/www/drupal2 $Color_Off"