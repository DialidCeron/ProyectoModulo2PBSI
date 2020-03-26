#! /bin/bash

#COLORSITOS

Color_Off='\033[0m'
Cyan='\033[0;36m'
Verde='\033[0;32m'
Rojo='\033[0;31m'

echo -e "$Cyan \n Actualizando Sistema Operativo.. $Color_Off"
sudo apt-get update -y > bitacora.log 2>&1
sudo apt-get upgrade -y >> bitacora.log 2>&1

if [[ $(grep -c "Err\|Fallo\|Error\|error" bitacora.log) != "0" ]]; 
then
	echo -e "$Rojo \n Fallo al actualizar el Sistema Operativo $Color_Off"
else
	#INSTALAR CURL
	echo -e "$Cyan \n Instalando curl.. $Color_Off"
	sudo apt-get install -y curl >> bitacora.log 2>&1
	if [[ $(grep -c "Err\|Fallo\|Error\|error" bitacora.log) != "0" ]]; then
		echo -e "$Rojo \n Error al instalar curl, deshaciendo los cambios... $Color_Off"
		sudo apt-get remove -y curl >> bitacora.log 2>&1
	else
		#INSTALAR GIT
		echo -e "$Cyan \n Instalando git.. $Color_Off"
		sudo apt-get install -y git >> bitacora.log 2>&1
		if [[ $(grep -c "Err\|Fallo\|Error\|error" bitacora.log) != "0" ]]; then
			echo -e "$Rojo \n Error al instalar git, deshaciendo los cambios... $Color_Off"
			sudo apt-get remove -y git >> bitacora.log 2>&1
		else
			#INSTALAR POSTGRES
			echo -e "$Cyan \n Instalando cliente de postgres.. $Color_Off"
			sudo apt-get install -y postgresql-client-11 >> bitacora.log 2>&1
			if [[ $(grep -c "Err\|Fallo\|Error\|error" bitacora.log) != "0" ]]; then
				echo -e "$Rojo \n Error al instalar cliente de postgres, deshaciendo los cambios... $Color_Off"
				sudo apt-get remove -y postgresql-client-11 >> bitacora.log 2>&1
			else
				#INSTALAR COMPOSER
				echo -e "$Cyan \n Instalando composer.. $Color_Off"
				curl -sS https://getcomposer.org/installer | php >> bitacora.log 2>&1
				mv composer.phar /usr/local/bin/composer >> bitacora.log 2>&1
				ln -s /usr/local/bin/composer /usr/bin/composer >> bitacora.log 2>&1
				if [[ $(grep -c "Err\|Fallo\|Error\|error" bitacora.log) != "0" ]]; then
					echo -e "$Rojo \n Error al instalar composer, deshaciendo los cambios... $Color_Off"
				else
					#INSTALAR DRUSH
					echo -e "$Cyan \n Instalando drush.. $Color_Off"
					git clone https://github.com/drush-ops/drush.git /usr/local/src/drush >> bitacora.log 2>&1
					cd /usr/local/src/drush >> bitacora.log 2>&1
					git checkout 7.0.0-alpha5 >> bitacora.log 2>&1
					ln -s /usr/local/src/drush/drush /usr/bin/drush >> bitacora.log 2>&1
					composer install >> bitacora.log 2>&1
					if [[ $(grep -c "Err\|Fallo\|Error\|error" bitacora.log) != "0" ]]; then
						echo -e "$Rojo \n Error al instalar composer, deshaciendo los cambios... $Color_Off"
					else
						#INSTALAR DRUPAL 8
						echo -e "$Cyan \n Instalando drupal.. $Color_Off"
						drush dl drupal-8.8.4 >> bitacora.log 2>&1
						mv /usr/local/src/drush/drupal-8.8.4 /var/www/drupal1
						drush dl drupal-8.8.4 >> bitacora.log 2>&1
						mv /usr/local/src/drush/drupal-8.8.4 /var/www/drupal2 >> bitacora.log 2>&1
						if [[ $(grep -c "Err\|Fallo\|Error\|error" bitacora.log) != "0" ]]; then
							echo -e "$Rojo \n Error al instalar drupal, deshaciendo los cambios... $Color_Off"
						else
							echo -e "$Verde \n Sitios instalados en /var/www/drupal1 y /var/www/drupal2 $Color_Off"
						fi
					fi
				fi
			fi 
		fi 
	fi
fi






