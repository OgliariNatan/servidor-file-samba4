#!/bin/bash
#
#####	NOME:				delete_file_olds.sh
#####	VERSÃO:				1.1
#####	DESCRIÇÃO:			Implementação rotina de remoção de arquivos com mais de 90dias da lixeira
#####	DATA DA CRIAÇÃO:	26/05/2023
#####	ESCRITO POR:		Natan Ogliari
#####	E-MAIL:				natanogliari@gmail.com
#####	DISTRO:				Ubuntu GNU/Linux 22.04
#####	LICENÇA:			MIT license
#####	PROJETO:			https://github.com/OgliariNatan/rotina_backup

echo -e "Entro no scripty de remoção de arquivos da lixeira \n\n"

cd /home/servidor/Área\ de\ Trabalho/lixeira

echo	"Mudou de dir"
echo -e "lista de arquivos: \t $(find . -type f -mtime +90)"
sudo find . -type f -mtime +90 -delete
#Não pode possuir espaço entre a vbariavél é o valor: var=val

echo  -e " este é o retorno: \t $? \t aqui"
#echo "REMOVEU......."

echo -e "Antecede os if \n ...."
 if [ $? == 0 ]; then
	#echo -e	"Entrou no if \n ...."
	echo -e "Foi apagado arquivos da lixeira." >> /home/servidor/Documentos/corpo_da_mensagem.txt
  else
    echo -e "Não foi apagado arquivos da lixeira \t o retorno do comando é: $?" >> /home/servidor/Documentos/corpo_da_mensagem.txt
 fi

echo "Fim do scripty de remoção da lixeira"
