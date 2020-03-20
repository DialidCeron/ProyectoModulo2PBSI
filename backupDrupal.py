#!/usr/bin/python3
import argparse
from os import path,popen,listdir,getcwd, pardir,system
from datetime import datetime
import subprocess

def parse():
	"""
		Funcion que permite manejar los parametros de entrada en la ejecuacion del script
	"""
	parser = argparse.ArgumentParser(   prog = 'Actualizador de drupal 7 al 8',
										usage= 'python3 actualizarDrupal.py -d directorioDelSitio',
                                        description = 'Script para la migración de Drupal 7 a Drupal 8.')

	groupListaUsuarios = parser.add_mutually_exclusive_group()
	parser.add_argument('-d','--directory',  type=str, help='Ruta del directorio en el que se encuentran\
		los sitios drupal: Por default buscara en /var/www',dest='ruta',nargs='?',const='/var/www',default='/var/www')

	return parser.parse_args()

home=popen("echo $HOME").readline()[0:-1]
directorioActual=getcwd()

def comprimirDirectorio(ruta,destino=""):
	nombre=ruta.split("/")
	nombre=nombre[-1] if nombre[-1] else nombre[-2] 
	rutaPadre=path.abspath(path.join(ruta, pardir))
	if system("\
		cd "+rutaPadre+";\
		tar -czvf "+directorioActual+"/"+nombre+".tar.gz "+nombre+" >/tmp/null")==0:
		return True

	return False

def obtenerSitiosDrupal(ruta):
	sitiosDrupal=[archivo for archivo in listdir(ruta) if path.isdir(path.join(ruta,archivo)) and \
		len(popen("cd "+path.join(ruta,archivo)+";drush status | grep -i drupal").readlines())>0 ]

	return sitiosDrupal


color = {
	'verde':'\033[0;32m',
	'rojo':'\033[0;31m',
	'off':'\033[0m',
	'cyan':'\033[0;36m'
}

def realizarRespaldoDeSitios(ruta):
	if(path.exists(ruta)):
		if(system("drush version 1>/tmp/null 2>/tmp/null") != 0):
			print("No existe Drush")
			print("Instalando Drush ...")
			out=popen("\
				curl -sS https://getcomposer.org/installer | php7.3;\
				sudo mv composer.phar /usr/local/bin/composer;\
				composer global require drush/drush:8.x;\
				sudo set -i '$a  export PATH=$PATH:$HOME/.config/composer/vendor/drush/drush/drush' /etc/bash.bashrc\
				").readlines()
			print(color['verde']+"Se ha instalado Drush"+color['off'],out)
			print(color['cyan']+"Ahora basta con escribir el comando:"+color['off']+color['verde']+"source /etc/bash.bashrc"+color['off'])
			print("para poder volver a ejecutar este programa de nuevo.")
			exit()
		if(not path.isfile("/usr/bin/git")):
			print("No existe Git")
			print("Instalando Git")
			if (system("sudo apt-get install git -y 1>/tmp/null")==0):
				print(color['verde']+"Se instalo de forma correcta GIT"+color['off'])
			else:
				print(color['rojo']+"No se pudo instalar GIT"+color['off'])


		print("------------------------------------------------------")
		print("\t\tBuscando sitios drupal en "+ruta)
		print("------------------------------------------------------")

		sitiosDrupal=obtenerSitiosDrupal(ruta)

		print("Se encontraron los siguientes sitios Drupal: ")
		i=0
		for ndirectorio in sitiosDrupal:
			i=i+1;
			print("{0}{1}) {2} {3}".format(color['verde'],i,ndirectorio,color['off']))

		print("------------------------------------------------------")
		print("				Respaldando sitios");
		print("------------------------------------------------------")

		sitiosRespaldados={}
		if(len(sitiosDrupal)>0):
			for sitio in sitiosDrupal:
				print("----------------> Respaldando sitio "+sitio+"<----------------")
				rutaSitio=path.join(ruta,sitio)
				if comprimirDirectorio(rutaSitio):
					print(color['verde']+"El sitio {0} se comprimio de forma correcta.{1}".format(sitio,color['off']))
					if (system("cd "+rutaSitio+"; drush -v sql-dump --result-file="+\
						path.join(directorioActual,"backup-"+sitio+"_"+\
							datetime.now().strftime("%d-%m-%Y_%H:%M:%S")+".sql"))==0):
						print(color['verde']+"Se realizo el respaldo de la base de datos correctamente del sitio: "+sitio+color['off'])
						print()
						sitiosRespaldados[sitio]=True
					else:
						print(color['rojo']+">>>>>> No se pudo realizar el respaldo de la base de datos de "+sitio+" <<<<<<<<"+color['off'])
						print()
						sitiosRespaldados[sitio]=False
		else:
			print("No se encontraron sitios Drupal")
	
	else:
		print(color['rojo']+"1,31m El directorio que ha ingresado no existe o no se puede acceder."+color['off'])

if __name__ == '__main__':
	argumentos=parse().__dict__
	ruta=argumentos["ruta"]
	realizarRespaldoDeSitios(ruta)