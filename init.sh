#!/bin/bash

escolha_operacao=$(dialog                    \
   --title 'Início'                          \
   --menu 'Qual operação deseja fazer?'      \
   0 0 0                                     \
   iniciar       'Iniciar backup'            \
   configurar    'Configurar origem backup'         \
   desagendar    'Desagendar backup'         \
   sair          'Sair' --stdout)

case $escolha_operacao in 
	'iniciar') source $(dirname $0)/app/backupDirChoice.sh;;
	'configurar') source $(dirname $0)/app/reconfigBackup.sh;;
	'desagendar') source $(dirname $0)/app/desagendarBackup.sh;;
	'sair') reset;;
esac
