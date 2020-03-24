#!/bin/bash

#COLORSITOS

Color_Off='\033[0m'
Cyan='\033[0;36m'
Verde='\033[0;32m'
Rojo='\033[0;31m' 

echo -e "$Cyan \n Actualizando Sistema Operativo.. $Color_Off"
sudo apt-get update -y > bitacora.log 2>&1

if [[ $(grep -c "Err\|Fallo\|Error\|error") !="0" ]]; then
	echo -e "$Rojo \n Fallo al actualizar el Sistema Operativo $Color_Off"
#&& sudo apt-get upgrade -y
else 
	echo -e "$Cyan \n Instalando Apache2.. $Color_Off"
	sudo apt-get install apache2 apache2-doc apache2-utils -y >> bitacora.log 2>&1
	if [[ $(grep -c "Err\|Fallo\|Error\|error") !="0" ]]; then
		echo -e "$Rojo \n Fallo al instalar apache, deshaciendo los cambios... $Color_Off"
		sudo apt-get remove apache2 apache2-doc apache2-utils -y >> bitacora.log 2>&1
	else
		echo -e "$Cyan \n Instalando PHP y Requerimientos $Color_Off"
		sudo apt-get install libapache2-mod-php php-common php-curl php-dev php-gd php-pear php-imagick php-xml php-mbstring php-cli -y >> bitacora.log 2>&1
		if [[ $(grep -c "Err\|Fallo\|Error\|error") !="0" ]]; then
			echo -e "$Rojo \n Fallo al instalar PHP y dependencias, deshaciendo los cambios... $Color_Off"
			sudo apt-get remove libapache2-mod-php php-common php-curl php-dev php-gd php-pear php-imagick php-xml php-mbstring php-cli -y >> bitacora.log 2>&1
		else
			echo -e "$Cyan \n Otorgando permisos para /var/www $Color_Off"
			sudo chown -R www-data:www-data /var/www >> bitacora.log 2>&1
			echo -e "$Verde \n Permisos cambiados $Color_Off"
			echo -e "$Cyan \n Habilitando módulos $Color_Off"
			sudo a2enmod rewrite >> bitacora.log 2>&1
			sudo a2enmod authnz_ldap >> bitacora.log 2>&1
			echo -e "$Cyan \n Reiniciando Apache $Color_Off"
			sudo service apache2 restart >> bitacora.log 2>&1
		fi 
	fi 
fi 

