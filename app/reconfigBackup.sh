#!/bin/bash

# Usando o dialog faz a pergunta de qual operação deseja fazer
# Com a resposta sendo armazenada dentro da variavel operação
operacao=$(dialog                 \
	--title 'Configurações'                    \
	--menu 'Qual operação deseja fazer?'  \
	0 0 0                                 \
	configHour      'Configurar hora de backup '   \
	addOrigin       'Adicionar origem'    \
	addDestiny      'Adicionar destino'   \
	limparOrigem    'Limpar origem'       \
	limparDestino   'Limpar destinos' --stdout)

# Compara para verificar se a operação selecionada é a addOrigin
if [ "$operacao" == "addOrigin" ]; then

	# Valida a entrada do caminho até que seja inserido um que exista
	until [ -d "$add_path" ]; do

		# Usando o dialog pede o caminho de
		# Com a resposta sendo armazenada dentro da variavel operação
		add_path=$(dialog                                                  \
			--title 'Adicione um caminho que você deseja fazer backup' \
			--fselect /        					   \
			0 0 --stdout)

        # Se o caminho não existe mostra o erro
		if [ ! -d "$add_path" ]; then
			# Mostra erro
			$(dialog                                \
				--title 'Erro'                  \
				--msgbox 'Arquivo não existe.'  \
				6 40 --stdout)
		fi
	done

	# Adiciona o caminho de origem no txt
	echo "$add_path" >> $CONFIG_BACKUP_DIR/dirOrigem.txt

# Compara para verificar se a operação selecionada é a addDestiny
elif [ "$operacao" == "addDestiny" ]; then
	until [ -d "$add_path" ]; do

		add_path=$(dialog                                                      \
			--title 'Adicione um caminho que você deseja salvar o backup'  \
			--fselect /       					       \
			0 0 --stdout)

        # Se o caminho não existe mostra o erro
		if [ ! -d "$add_path" ]; then
			# Mostra erro
			$(dialog                                \
				--title 'Erro'                  \
				--msgbox 'Arquivo não existe.'  \
				6 40 --stdout)
        fi
   	done

	echo "$add_path" > $CONFIG_BACKUP_DIR/dirDestino.txt

# Compara para verificar se a operação selecionada é a limparOrigem
elif [ "$operacao" == "limparOrigem" ]; then

	# Limpa as origems
	echo "" > $CONFIG_BACKUP_DIR/dirOrigem.txt

# Compara para verificar se a operação selecionada é a configHour
elif [ "$operacao" == "configHour" ]; then

	# Usando o dialog pede a hora do backup
	# Com a resposta sendo armazenada dentro da variavel time
	time=$(dialog                                  \
		--title 'Ajuste a hora do backup'          \
		--timebox '\nDICA: Use as setas e o TAB.'  \
		0 0                                        \
		23 --stdout)

    # Pega apenas a hora da variavel time recortando o ":"
	hour=$(echo $time | cut -f1 -d:)

    # Escreve um arquivo de configuração do crontab
	echo "0 $hour * * * $CONFIG_BACKUP_DIR/../app/backupDirChoice.sh" > ${CONFIG_BACKUP_DIR}/crontabScheduling.txt

	# Ativa o crontab com a configuração do arquivo criado acima
	crontab ${CONFIG_BACKUP_DIR}/crontabScheduling.txt

# Compara para verificar se a operação selecionada é a limparDestino
elif [ "$operacao" == "limparDestino" ]; then

	# Limpa as origems
	echo "" > $CONFIG_BACKUP_DIR/dirDestino.txt


fi