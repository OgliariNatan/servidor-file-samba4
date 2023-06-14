#!/bin/bash
##
#####	NOME:				rotina_backup_diario.sh
#####	VERSÃO:				0.1
#####	DESCRIÇÃO:			Implementação rotina de backup diario com arquivos modificados
#####	DATA DA CRIAÇÃO:		14/06/2023
#####	ESCRITO POR:			Natan Ogliari
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
echo -e "Inicializado o backup diario" $(date +%d%m%y--%H:%M) >> /home/servidor/Documentos/corpo_da_mensagem.txt
tar -cfz -G /home/servidor/Documentos/win/backup_diario.tar.gz /home/servidor/Área\ de\ Trabalho/Compartilhamento
#echo -e $(ls -lth /home/Documentos/win) >> /home/servidor/Documentos/corpo_da_mensagem.txt
echo -e "Finalizado o backup diario\n" >> /home/servidor/Documentos/corpo_da_mensagem.txt
echo -e "################################"
