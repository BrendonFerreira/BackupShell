#!/bin/bash

#Cria um Log, adiciona a data e horário na variável “$INICIO” e cria o arquivo de log onde na variável “LOG” é informado o caminho e o nome do #arquivo de log neste caso, será na pasta #/var/log/projeto/ e o arquivo se chamará YYYY/MM/DD_log-dir-choice-bkp
INICIO=`date +%d/%m/%Y-%H:%M:%S`
LOG=$PWD/`date +%Y-%m-%d`_log-dir-choice.txt

#Monta o cabeçalho do arquivo de log
printf "\n\n|-----------------------------------------------" >> $LOG
printf " Sincronização iniciada em $INICIO" >> $LOG
#Fim do cabeçalho

# Lê cada linha do arquivo como origens do backup
cat $CONFIG_BACKUP_DIR/dirOrigem.txt | while read dirrOrigem do

	# Lê cada linha do arquivo como destino do backup
	cat $CONFIG_BACKUP_DIR/dirDestino.txt | while read dirrDestino do	
		#Inicia o BKP usando RSYNC, os parametros -Cravzp quer dizer que o rsync está sendo acionado para:
		#-C: auto-ignorar arquivos idênticos;
		#-r: copiar de forma recursiva, ou seja, todos os diretórios e subdiretórios no caminho especificado;
		#-a: indica que estarão sendo copiados arquivos;
		#-v: modo verboso, mais informações da cópia;
		#-z: comprime os arquivos durante a cópia;
		#-p: indicador de progresso de cópia.
		sudo rsync -Cravzp $dirrOrigem $dirrDestino >> $LOG
	done
done

FINAL=`date +%d/%m/%Y-%H:%M:%S`

#Variavel "$FINAL" recebe o dia e hora em que o BKP terminou
#Abaixo monta o rodapé do arquivo de log.

echo " Sincronização Finalizada em $FINAL" >> $LOG
printf "|-----------------------------------------------/n/n" >> $LOG
