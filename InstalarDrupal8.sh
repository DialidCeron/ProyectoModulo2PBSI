#! /bin/bash
sudo apt -y update && apt -y upgrade
#INSTALAR CURL
sudo apt install -y curl
#INSTALAR GIT
sudo apt install -y git
#INSTALAR PHP
sudo apt install -y php php-xml php-fpm php-pgsql libapache2-mod-php php-mbstring
#INSTALAR POSTGRES
sudo apt install -y postgresql-11 postgresql-client-11
#INSTALAR COMPOSER
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
ln -s /usr/local/bin/composer /usr/bin/composer
#INSTALAR DRUSH
git clone https://github.com/drush-ops/drush.git /usr/local/src/drush
cd /usr/local/src/drush
git checkout 7.0.0-alpha5
ln -s /usr/local/src/drush/drush /usr/bin/drush
composer install
#INSTALAR DRUPAL 8
drush dl drupal-8.8.4
mv /usr/local/src/drush/drupal-8.8.4 /var/www/sitio1

