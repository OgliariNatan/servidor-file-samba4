#!/bin/bash
#
#####	NOME:				delete_file_olds.sh
#####	VERSÃO:				1.2
#####	DESCRIÇÃO:			Implementação rotina de remoção de arquivos com mais de 90dias da lixeira
##### e cria um registro de log para este scripty
#####	DATA DA CRIAÇÃO:	26/05/2023
##### ATUALIZADO EM: 18/08/2023
#####	ESCRITO POR:		Natan Ogliari
#####	E-MAIL:				natanogliari@gmail.com
#####	DISTRO:				Ubuntu GNU/Linux 22.04
#####	LICENÇA:			MIT license
#####	PROJETO:			https://github.com/OgliariNatan/servidor-file-samba4

echo -e "Removendo arquivos na data de: $(date +%d%m%y)" >> /home/servidor/backup/log/log.delete_file_olds
echo -e "Entro no scripty de remoção de arquivos da lixeira \n\n" >> /home/servidor/backup/log/log.delete_file_olds

cd /home/servidor/backup/lixeira

echo	"Mudou de dir"
echo -e "lista de arquivos: \t $(find . -type f -mtime +90)"
sudo find . -type f -mtime +90 -delete
#Não pode possuir espaço entre a vbariavél é o valor: var=val

echo  -e " este é o retorno: \t $? \t aqui"
#echo "REMOVEU......."

echo -e "Antecede os if \n ...."
 if [ $? == 0 ]; then
	#echo -e	"Entrou no if \n ...."
	echo -e "Foi apagado arquivos da lixeira." >> /home/servidor/backup/log/log.delete_file_olds
  else
    echo -e "Não foi apagado arquivos da lixeira \t o retorno do comando é: $?" >> /home/servidor/backup/log/log.delete_file_olds
 fi

echo "Fim do scripty de remoção da lixeira" >> /home/servidor/backup/log/log.delete_file_olds
