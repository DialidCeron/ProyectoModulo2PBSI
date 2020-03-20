#!/bin/bash
cp /var/www/drupal1/.htaccess ./.htaccess1
cp /var/www/drupal2/.htaccess ./.htaccess2

cp /etc/apache2/sites-available/drupal1.conf .
cp /etc/apache2/sites-available/drupal2.conf .

cp /etc/apache2/apache2.conf .
cp /etc/apache2/conf-available/security.conf .

tar -czvf configuracionApache.tar.gz .htaccess1 .htaccess2 drupal1.conf drupal2.conf apache2.conf security.conf
rm .htaccess1 .htaccess2 drupal1.conf drupal2.conf security.conf apache2.conf

