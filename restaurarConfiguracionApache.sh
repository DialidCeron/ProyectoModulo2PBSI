#!/bin/bash

tar -xvzf configuracionApache.tar.gz 

mv .htaccess1 /var/www/drupal1/.htaccess
mv .htaccess2 /var/www/drupal2/.htaccess

mv drupal1.conf /etc/apache2/sites-available
mv drupal2.conf /etc/apache2/sites-available

mv apache2.conf /etc/apache2/
mv security.conf /etc/apache2/conf-available






