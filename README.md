#Repositorio com arquivos de configuração do servidor de arquivos.

##smb.conf
Arquivo de configuração do samba.

## rotina_backup.sh
Implementação de uma rotina de uma automação de backup de arquivos compartilhados com o samba.


## Para apagar os registro de LOGIN no WIN

net use * /delete /y


##Para auditoria em tempo real

tail -f /var/log/syslog

## Configuração de auditoria
Criar um arquivo em: /etc/rsyslog.d/auditsamba.conf
