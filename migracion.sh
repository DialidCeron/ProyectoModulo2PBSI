cd /var/www/Drupal1
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

echo "
#// Database entry for `drush migrate-upgrade --configure-only`
$databases['upgrade']['default'] = array (
 'database' => '$dbname',
 'username' => '$dbuser',
 'password' => '$dbpass',
 'prefix' => '',
 'host' => '$ip',
 'port' => '5432',
 'namespace' => 'Drupal\\Core\\Database\\Driver\\pgsql',
 'driver' => 'pgsql',
);
#// Database entry for `drush migrate-import --all`
$databases['migrate']['default'] = array (
 'database' => 'dbname',
 'username' => 'dbuser',
 'password' => 'dbpass',
 'prefix' => '',
 'host' => 'localhost',
 'port' => '5432',
 'namespace' => 'Drupal\\Core\\Database\\Driver\\pgsql',
 'driver' => 'pgsql',
);" >> /var/www/Drupal1/sites/default/setting.php

echo "Proceso de migración";
sudo drush migrate-upgrade
#sudo drush migrate-status
drush migrate-import --all
