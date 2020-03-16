#!/usr/bin/python3
import argparse
import os.path

def parse():
	"""
		Funcion que permite manejar los parametros de entrada en la ejecuacion del script
	"""
	parser = argparse.ArgumentParser(   prog = 'Actualizador de drupal 7 al 8',
										usage= 'python3 actualizarDrupal.py -d directorioDelSitio',
                                        description = 'Script para la migración de Drupal 7 a Drupal 8.')

	groupListaUsuarios = parser.add_mutually_exclusive_group()
	parser.add_argument('-d','--directory',  type=str, help='Ruta del directorio en el que se encuentra\
							 el sitio Drupal',dest='ruta', required=True)

	return parser.parse_args()


argumentos=parse().__dict__

def existeDrush():
	if(os.path.exists("~/.config/composer/vendor/drush/drush/")):
		return True
	return True

if(os.path.exists(argumentos['ruta'])):
	if(not os.path.exists("~/.config/composer/vendor/drush/drush/")):
		print("No existe Drush")
		print("Instalando Drush ...")
		s = os.popen("\
			curl -sS https://getcomposer.org/installer | php7.3;\
			sudo mv composer.phar /usr/local/bin/composer;\
			composer global require drush/drush:8.x;\
			sudo echo 'export PATH=$PATH:$HOME/.config/composer/vendor/drush/drush' >> /etc/bash.bashrc;\
			source /etc/bash.bashrc;\
			").readlines()
		print("Se ha instalado Drush",s)
	if(not os.path.isfile("/usr/bin/git")):
		print("No existe Git")
		print("Instalando Git")
		os.popen("sudo apt-get install git")
	

else:
	print("El directorio que ha ingresado no existe o no se puede acceder.")
