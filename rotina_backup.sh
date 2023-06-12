#!/bin/bash
##
#####	NOME:				rotina_backup.sh
#####	VERSÃO:				1.1
#####	DESCRIÇÃO:			Implementação rotina de remoção de arquivos com mais de 90dias da lixeira
#####	DATA DA CRIAÇÃO:	26/03/2023
#####	ESCRITO POR:		Natan Ogliari
#####	E-MAIL:				natanogliari@gmail.com
#####	DISTRO:				Ubuntu GNU/Linux 22.04
#####	LICENÇA:			MIT license
#####	PROJETO:			https://github.com/OgliariNatan/servidor-file-samba4
#########################Torne o scripty executavél ##########
## chmod u+x novo_script
##############################
## Script idealizado para manter uma política de backup dos arquivos
## compartilhados no Servidor de Arquivos.
##
## A linha mais abaixo é uma maneira otimizada de backup, pois realiza
## a compactação dos arquivos compartilhados e já os coloca na pasta
## montada referente ao servidor de backup.
##
##Opção: [v] exibe o progresso, [p] mantem as permissões

#tar -czf /home/servidor/Documentos/backup/backup_$(date +%d%m%y).tar.gz /home/servidor/Área\ de\ Trabalho/Compartilhamento
echo -e "\n ################## INICIO ##################\n\n"
#Cria a variavel do backup
nome_arq=/home/servidor/Documentos/backup_$(date +%d%m%y).tar.gz
#escreve no arquivo os backup
echo $(ls /home/servidor/Documentos/backup) > /home/servidor/Documentos/corpo_da_mensagem.txt
nome_arquivo=($nome_arq)
#echo "nome do arquivo:" $nome_arquivo
#Informa a quantidade de arquivos existentes na pasta
qtd_arq=$(find /home/servidor/Documentos/backup/ -type f | wc -l)

echo  -e "Quantidade de backup na pasta:\t" $(find /home/servidor/Documentos/backup/ -type f | wc -l) >> /home/servidor/Documentos/corpo_da_mensagem.txt

if [$qtd_arq -ge 1];	then
		#echo "Entrou no IF"
		echo "Irá remover o arquivo:" $(find /home/servidor/Documentos/backup/ -mtime +6) >> /home/servidor/Documentos/corpo_da_mensagem.txt
		rm -f $(find /home/servidor/Documentos/backup/ -mtime +6)
		sleep 2
else
		echo -e "\n###############\n"
		echo -e "Não entrou no IF \n"
		echo  -e "\nEncontrou este arquivo:\t" $(find /home/servidor/Documentos/backup/ -mtime +1) >> /home/servidor/Documentos/corpo_da_mensagem.txt
		echo -e "\n###############\n"
fi

#echo "Removeu o arquivo"
sleep 2

###################################
########### INICIO BACKUP ###########
##Primeiro remove os backup antigos e posterior realiza um novo backup

tar -czf /home/servidor/Documentos/backup/backup_$(date +%d%m%y).tar.gz /home/servidor/Área\ de\ Trabalho/Compartilhamento
sleep 5
######### FIM BACKUP ##########
##############################
## Sistema para informar o que esta acontecendo com o backup,
## para enviar via e-mail as informações das saidas

echo -e "tamanho do backup:\t $(ls -sh /home/servidor/Documentos/backup)" >> /home/servidor/Documentos/corpo_da_mensagem.txt


## Envia via e-mail quando houver falha no backup

##IMPLEMENTAR AQUI !!!!!!!

## ao final reinicia o  servidor

echo "Backup Finalizado em:" $(date +%d%m%y¨%a¨), Dir do backup: $nome_arq >> /home/servidor/Documentos/corpo_da_mensagem.txt
echo "Possui" $(find /home/servidor/Documentos/backup/ -type f | wc -l) "Arquivos de backup" >> /home/servidor/Documentos/corpo_da_mensagem.txt
echo "Uso do disco sda6:" $(df -h /dev/sda6) >> /home/servidor/Documentos/corpo_da_mensagem.txt
echo "\n \n" >> /home/servidor/Documentos?corpo_da_mensagem.txt
sleep 5

echo -e "\n############################ FIM ######################\n\n"
reboot
#halt --reboot
