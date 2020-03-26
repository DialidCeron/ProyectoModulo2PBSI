#!/usr/bin/python3
from colores import imprimir
from os import path,popen,listdir,getcwd, pardir,system


def restaurarBDDrupal(sql,username,puerto,host,nombreBaseDatos,nombreSitio):
	if len(puerto)==0:
		puerto="5432"
	if(system("sudo -u postgres psql -h "+host+" -p "+puerto+" -U "+username+" -f "+sql+" "+nombreBaseDatos)==0):
		imprimir("verde","Se restauro correctamente la base de datos: "+nombreBaseDatos+\
			"del sitio"+nombreSitio)
	else:
		imprimir("rojo","Error: No se pudo restaurar")


def restaurarDirectorioDrupal(archivo,ruta):
	if path.isfile(archivo):
		if path.isdir(ruta):
			if system("sudo tar -xzf "+archivo+" -C "+ruta)==0:
				imprimir('verde',"Se ha descomprimido correctamente el respaldo en la ruta especificada")
				
			else:
				imprimir('rojo',"Error: No se pudo descomprimir el archivo, verifique que tenga permisos de escritra.")
		else:
			imprimir('rojo',"No existe la ruta "+ruta)
	else:
		imprimir('rojo',"No existe el archivo "+archivo+" para descomprimir.");	



def obtenerInfoRespaldo():
	sitios=[]
	imprimir('cyan',"Sitios a respaldar:")
	if path.isfile("reporteSitiosBackup.info"):
		archivo=open("reporteSitiosBackup.info","r")
		sitio={}
		i=0
		n=0
		for l in archivo.readlines():
			tokens=l.split(":")
			sitio[tokens[0]]=tokens[1][0:-1] #Se quita el salto de linea en la cadena
			i=i+1
			if(i%9==0):
				sitios.append(sitio)
				n=n+1
				imprimir('verde',"\t"+str(n)+")"+sitio['sitio'])	
				sitio={}
	return sitios


def restaurarDrupal():
	sitiosRespaldados=obtenerInfoRespaldo()
	if len(sitiosRespaldados)>0:
		for sitio in sitiosRespaldados:
			restaurarDirectorioDrupal(sitio['backupSitioName'],"/var/www")
			restaurarBDDrupal(sitio['backupDB'],
				sitio['Databaseusername'],
				sitio['Databaseport'],
				sitio['Databasehostname'],
				sitio['Databasename'].
				sitio['sitio'])
	else:
		imprimir("rojo","Error: No existe el archivo de reporteSitiosBackup: ")
		imprimir("rojo","Sugerencia: ejecute el script backupDrupal previamente a ejecutar este script.")

restaurarDrupal()
