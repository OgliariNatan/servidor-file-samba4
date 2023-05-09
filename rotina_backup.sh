#!/bin/bash
## Script idealizado para manter uma política de backup dos arquivos
## compartilhados no Servidor de Arquivos.
##
## A linha mais abaixo é uma maneira otimizada de backup, pois realiza
## a compactação dos arquivos compartilhados e já os coloca na pasta
## montada referente ao servidor de backup.
##
##Opção: [v] exibe o progresso, [p] mantem as permissões

#tar -czf /home/servidor/Documentos/backup/backup_$(date +%d%m%y).tar.gz /home/servidor/Área\ de\ Trabalho/Compartilhamento

nome_arq=/home/servidor/Documentos/backup_$(date +%d%m%y).tar.gz

echo $(ls /home/servidor/Documentos/backup) > /home/servidor/Documentos/arquivos.txt

while read arq; do
	#echo "Entrou no while leitura do arquivo"
	nome_arquivo=($arq)
	#echo "nome do arquivo:" $nome_arquivo
	#Informa a quantidade de arquivos existentes na pasta
	qtd_arq=$(find /home/servidor/Documentos/backup/ -type f | wc -l)
	echo "Quantidade de arquivo:" $qtd_arq
	#echo "Quantidade de backup na pasta:" $(find /home/servidor/Documentos/backup/ -type f | wc -l)
	#if((1#${#nome_arquivo[@]}>2))
	#Caso possua mais do que 1 arquivo remova o arquivo antigo
	if (($qtd_arq > 1))
	then
		#echo "Entrou no IF"
		echo "Irá remover o arquivo:" $(find /home/servidor/Documentos/backup/ -mtime +4,9)
		rm -f $(find /home/servidor/Documentos/backup/ -mtime +4,9)
	else
		echo "Não entrou no IF"
		echo "Encontrou este arquivo" $(find /home/servidor/Documentos/backup/ -mtime +4,9)
	fi
done < /home/servidor/Documentos/arquivos.txt
#echo "Terminou o wilhe"
rm /home/servidor/Documentos/arquivos.txt
#echo "Removeu o arquivo"
###################################
########### INICIO BACKUP ###########
##Primeiro remove os backup antigos e posterior realiza um novo backup
##o backup é realizado através de arquivo compactado
tar -czf /home/servidor/Documentos/backup/backup_$(date +%d%m%y).tar.gz /home/servidor/Área\ de\ Trabalho/Compartilhamento

######### FIM BACKUP ##########
##############################
## Sistema para informar o que esta acontecendo com o backup,
## para enviar via e-mail as informações das saidas
################################
#Informa o tamanho dos arquivos
echo $(ls -sh /home/servidor/Documentos/backup) >> /home/servidor/Documentos/corpo_da_mensagem.txt


## Envia via e-mail quando houver falha no backup

##IMPLEMENTAR AQUI !!!!!!!

echo "Backup Finalizado em:" $(date +%d%m%y¨%a¨), Dir do backup: $nome_arq >> /home/servidor/Documentos/corpo_da_mensagem.txt
echo "Possui" $(find /home/servidor/Documentos/backup/ -type f | wc -l) "Arquivos de backup" >> /home/servidor/Documentos/corpo_da_mensagem.txt
echo "Uso do disco sda6:" $(df -h /dev/sda6) >> /home/servidor/Documentos/corpo_da_mensagem.txt
#########Reiniciação da maquina servidor de Arquivos

#Implementar aqui
reboot
