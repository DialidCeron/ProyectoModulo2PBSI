cd /var/www/drupal1
#INSTALAR MODULOS NECESARIOS PARA LA MIGRACION
echo "Instalando modulos";
sudo drush en migrate_tools -y 
sudo drush en migrate_upgrade -y 

echo "Nombre de la base de datos";
read dbname;
echo "Usuario de la bd";
read dbuser;	
echo "Contraseña de la bd";
read contra;
echo "IP de la bd";
read ip;

echo "Proceso de migración";
sudo drush migrate-upgrade --configure-only --legacy-db-url=pgsql://$dbuser:$dbpass@$ip/$dbname --legacy-root=/var/www/drupal/sites/default/files
#sudo drush migrate-status
sudo drush migrate-import --all

