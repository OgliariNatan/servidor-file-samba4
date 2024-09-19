#!/bin/bash
#
#####   NOME:                           delete_file_olds.sh
#####   VERSÃO:                         1.2
#####   DESCRIÇÃO:                      Implementação rotina de remoção de arquivos com mais de 90dias da lixeira
##### e cria um registro de log para este scripty
#####   DATA DA CRIAÇÃO:        26/05/2023
##### ATUALIZADO EM: 18/08/2023
#####   ESCRITO POR:            Natan Ogliari
#####   E-MAIL:                         natanogliari@gmail.com
#####   DISTRO:                         Ubuntu GNU/Linux 22.04
#####   LICENÇA:                        MIT license
#####   PROJETO:                        https://github.com/OgliariNatan/servidor-file-samba4

echo -e "Removendo arquivos na data de: $(date +%d%m%y)" >> /home/servidor/samba/conf/log/log.delete_file_olds
echo -e "Entro no scripty de remoção de arquivos da lixeira \n\n" >> /home/servidor/samba/conf/log/log.delete_file_olds

cd /home/servidor/samba/data/lixeira

echo    "Mudou de dir"
echo -e "lista de arquivos: \t $(find /home/servidor/samba/data/lixeira -type f -mtime +90)" >> /home/servidor/samba/conf/log/log.delete_file_olds

##Apaga os arquivos da lixeira
sudo find /home/servidor/samba/data/lixeira -type f -mtime +90 -delete

#Não pode possuir espaço entre a vbariavél é o valor: var=val

echo  -e " este é o retorno do comando: \t "$? >> /home/servidor/samba/conf/log/log.delete_file_olds


echo -e "Antecede os if \n ...."
 if [ $? == 0 ]; then
        #echo -e        "Entrou no if \n ...."
        echo -e "Foi apagado arquivos da lixeira." >> /home/servidor/samba/conf/log/log.delete_file_olds
  else
    echo -e "Não foi apagado arquivos da lixeira \n o retorno do comando é: $?" >> /home/servidor/samba/conf/log/log.delete_file_olds
 fi

echo "Fim do scripty de remoção da lixeira" >> /home/servidor/samba/conf/log/log.delete_file_olds
