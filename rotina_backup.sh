#!/bin/bash
#--------------------------------------------------------------------------------------
#####	NOME:				rotina_backup.sh
#####	VERSÃO:				1.3
#####	DESCRIÇÃO:			Implementação rotina de backup
#####	DATA DA CRIAÇÃO:		26/03/2023
#####	ESCRITO POR:			Natan Ogliari
#####	E-MAIL:				natanogliari@gmail.com
#####	DISTRO:				Ubuntu GNU/Linux 22.04
#####	LICENÇA:			MIT license
#####	PROJETO:			https://github.com/OgliariNatan/servidor-file-samba4
#########################Torne o scripty executavél ##########
## chmod +x novo_script
##############################
## Script idealizado para manter uma política de backup dos arquivos
## compartilhados no Servidor de Arquivos.
##
## A linha mais abaixo é uma maneira otimizada de backup, pois realiza
## a compactação dos arquivos compartilhados e já os coloca na pasta
## montada referente ao servidor de backup.
##
##
#-----------------------------------------------------------------------------------------
#tar -czf /home/servidor/backup/backup_$(date +%d%m%y).tar.gz /home/servidor/Compartilhados
#echo -e "\n ################## INICIO ##################\n\n"
#Cria a variavel do backup

	local nome_arq=/home/servidor/backup/backup/backup$(date +%d%m%y).tar.gz
	#escreve no arquivo os backup
	echo $(ls /home/servidor/backup/backup) > /home/servidor/backup/log/corpo_da_mensagem.txt

	#Informa a quantidade de arquivos existentes na pasta
	#qtd_arq=$(find /home/servidor/Documentos/backup/ -type f | wc -l)
	local qtd_arq=$(ls /home/servidor/backup/backup | wc -l)
	echo  -e "Quantidade de backup na pasta:\t" $(find /home/servidor/backup/backup -type f | wc -l) >> /home/servidor/backup/log/corpo_da_mensagem.txt
	#qtd_arq=1
	#############################################
	#Quantidade de arquivos de backup a ser mantido
	local par_teste=1
	echo -e "Minha variavel vale:\t" $qtd_arq

	if [ $qtd_arq -ge $par_teste ];	then
		#echo "Entrou no IF"
		echo "Irá remover o arquivo:" $(find /home/servidor/backup/backup -mtime +6) >> /home/servidor/backup/log/corpo_da_mensagem.txt
		rm -f $(find /home/servidor/backup/backup -mtime +6)
		#sleep 2
	else
		#echo -e "\n###############\n"
		#echo -e "Não entrou no IF \n"
		echo  -e "\nEncontrou este arquivo:\t" $(find /home/servidor//backup/backup -mtime +1) >> /home/servidor/backup/log/corpo_da_mensagem.txt
		#echo -e "\n###############\n"
	fi

	#sleep 2

	###################################
	########### INICIO BACKUP ###########
	##Primeiro remove os backup antigos e posterior realiza um novo backup
	echo -e "\n Iniciou  o backup\n" >> /home/servidor/backup/log/corpo_da_mensagem.txt
	#Realiza o backup
	tar -czf /home/servidor/backup/backup/backup$(date +%d%m%y--%H%M).tar.gz /home/servidor/Compartilhados
	sleep 2
	######### FIM BACKUP ##########
	##############################
	## Sistema para informar o que esta acontecendo com o backup,
	## para enviar via e-mail as informações das saidas

	echo -e "tamanho do backup:\t $(ls -sh /home/servidor/backup/backup)" >> /home/servidor/backup/log/corpo_da_mensagem.txt


	## Envia via e-mail quando houver falha no backup

	##IMPLEMENTAR AQUI !!!!!!!

	## ao final reinicia o  servidor

	echo "Backup Finalizado em:" $(date +%d%m%y¨%a¨-%H%M)", Dir do backup:" $nome_arq >> /home/servidor/backup/log/corpo_da_mensagem.txt
	echo "Possui" $(find /home/servidor/backup/backup -type f | wc -l) "Arquivos de backup" >> /home/servidor/backup/log/corpo_da_mensagem.txt
	echo -e "Uso do disco backup:\t" $(df -h /dev/sdb1) >> /home/servidor/backup/log/corpo_da_mensagem.txt
	echo -e "Uso do disco do servidor:\t" $(df -h /dev/mapper/ubuntu--vg-ubuntu--lv) >> /home/servidor/backup/log/corpo_da_mensagem.txt
	echo "\n \n" >> /home/servidor/backup/log/corpo_da_mensagem.txt
	sleep 2

	#echo -e "\n############################ FIM ######################\n\n"
	#reboot
	#halt --reboot
	unset qtd_arq nome_arq par_set


###################
#Para usar
#rsync -avz servidor@10.40.22.35:/home/servidor/Área\ de\ Trabalho/Compartilhamento/ /home/servidor/Compartilhados
#rsync -avz servidor@10.40.22.35:/home/servidor/Área\ de\ Trabalho/Arquivados/ /home/servidor/backup/arquivados



###################################



#/home/servidor/backup/log
#/home/servidor/backup/backup
