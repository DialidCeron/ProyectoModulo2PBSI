color = {
	'verde':'\033[0;32m',
	'rojo':'\033[0;31m',
	'off':'\033[0m',
	'cyan':'\033[0;36m'
}

def imprimir(c,mensaje):
	print(c+mensaje+color['off'])
