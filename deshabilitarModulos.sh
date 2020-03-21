#!/bin/bash

echo "Deshabilitando modulos sitio1."
cd /var/www/drupal1
#primero lista los modulos activos, luego los deshabilita
drush pml --no-core --type=module --status=enabled --pipe | xargs drush -y dis

echo "Deshabilitando modulos sitio2."
cd /var/www/drupal2
drush pml --no-core --type=module --status=enabled --pipe | xargs drush -y dis
