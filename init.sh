#!/bin/bash


source $(dirname $0)/test.sh

if [ -n "$CONFIG_BACKUP_DIR" ] 
then 
	echo "Aplicação configurada"
else 
	echo "A aplicação não foi devidamente configurada"
fi