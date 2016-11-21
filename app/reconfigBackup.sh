#!/bin/bash

#TODO Adicionar origem 
#TODO adicionar destino 
operacao=$(dialog                        \
   --title 'Caminhos'                    \
   --menu 'Qual operação deseja fazer?'  \
   0 0 0                                 \
   addOrigin       'Adicionar origem'    \
   addDestiny      'Adicionar destino'   \
   configHour	   'Configurar hora'	 \
   limpar    'Limpar lista' --stdout)


if [ "$operacao" == "addOrigin" ]; then
   	
   	until [ -d "$add_path" ]; do
      	add_path=$(dialog                                                 \
            --title 'Adicione um caminho que você deseja fazer backup'    \
            --fselect /        						                      \
            0 0 --stdout)

	    if [ ! -d "$add_path" ]; then
	    	$(dialog                            \
				--title 'Erro'                  \
				--msgbox 'Arquivo não existe.'  \
				6 40 --stdout)
      	fi
   	done
   	echo "$add_path" >> $CONFIG_BACKUP_DIR/dirOrigem.txt

elif [ "$operacao" == "addDestiny" ]; then 
	
	until [ -d "$add_path" ]; do
      	add_path=$(dialog                                               \
            --title 'Adicione um caminho que você deseja fazer backup'  \
            --fselect /       							\
            0 0 --stdout)

	    if [ ! -d "$add_path" ]; then
	    	$(dialog                            \
				--title 'Erro'                  \
				--msgbox 'Arquivo não existe.'  \
				6 40 --stdout)
      fi
   	done
	echo "$add_path" > $CONFIG_BACKUP_DIR/dirDestino.txt


elif [ "$operacao" == "addDestiny" ]; then 

	until [ -d "$add_path" ]; do
      	add_path=$(dialog                                               \
            --title 'Adicione um caminho que você deseja fazer backup'  \
            --fselect /       											\
            0 0 --stdout)

	    if [ ! -d "$add_path" ]; then
	    	$(dialog                            \
				--title 'Erro'                  \
				--msgbox 'Arquivo não existe.'  \
				6 40 --stdout)
      fi
   	done
	echo "$add_path" > $CONFIG_BACKUP_DIR/dirDestino.txt

elif [ "$operacao" == "configHour" ]; then 
	
	time=$(dialog                              \
		--title 'Ajuste a hora do backup'          \
		--timebox '\nDICA: Use as setas e o TAB.'  \
		0 0                                        \
		23 --stdout)

	hour=$(echo $time | cut -f1 -d:) 
	
	echo "0 $hour * * * ../app/backupDirChoice.sh" > $CONFIG_BACKUP_DIR/crontabScheduling.txt
	crontab $CONFIG_BACKUP_DIR/crontabScheduling.txt

elif [ "$operacao" == "limpar" ]; then 

	echo "" > $CONFIG_BACKUP_DIR/dirOrigem.txt

fi