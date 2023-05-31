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

echo  "Entrou no scripty"
cd /home/servidor/Área\ de\ Trabalho/lixeira
echo -e "Mudou de dir \n ...."
sudo find . -type f -mtime +90 -delete
echo -e "Antecede o IF \n ---------"
 if ($? -ne 0); then #Grava informações em um arquivo.txt externo
      echo "Entrou na primeira condição"
      echo "Foi apagado arquivos da lixeira" >> /home/servidor/Documentos/corpo_da_mensagem.txt
  else
    echo "Entrou na segunda condição"
    echo "Não foi apagado arquivos da lixeira" >> /home/servidor/Documentos/corpo_da_mensagem.txt
 fi
echo "Fim do scripty"
