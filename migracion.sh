#INSTALAR MODULOS NECESARIOS PARA LA MIGRACION
sudo drush en migrate_tools -y 
#sudo drush en migrate_upgrade -y 

// Database entry for `drush migrate-upgrade --configure-only`
$databases['upgrade']['default'] = array (
 'database' => 'dbname',
 'username' => 'dbuser',
 'password' => 'dbpass',
 'prefix' => '',
 'host' => 'localhost',
 'port' => '5432',
 'namespace' => 'Drupal\\Core\\Database\\Driver\\pgsql',
 'driver' => 'pgsql',
);
// Database entry for `drush migrate-import --all`
$databases['migrate']['default'] = array (
 'database' => 'dbname',
 'username' => 'dbuser',
 'password' => 'dbpass',
 'prefix' => '',
 'host' => 'localhost',
 'port' => '5432',
 'namespace' => 'Drupal\\Core\\Database\\Driver\\pgsql',
 'driver' => 'pgsql',
);

sudo drush migrate-upgrade --legacy-db-url=pgsql://root@localhost/
--legacy-root=/Ubicacion --configure-only
sudo drush migrate-status
drush migrate-import --all