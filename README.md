# Repositorio com arquivos de configuração do servidor de arquivos.

Um pequeno manual de como configurar um servidor de arquivos com acesso por user&password com o SAMBA.

### Autorizar as porta

*ufw allow ssh | ufw allow 22 #porta do samba (22)


## smb.conf

Arquivo de configuração do samba.

## rotina_backup.sh

Implementação de uma rotina de uma automação de backup de arquivos compartilhados com o samba.


## Para apagar os registro de LOGIN no WIN

* net use * /delete /y


## Para auditoria em tempo real

* tail -f /var/log/syslog

## Configuração de auditoria

Criar um arquivo em:
* /etc/rsyslog.d/auditsamba.conf

## Testando a configuração do SAMBA

testparm => Realiza o teste do arquivo smb.conf

## Reiniciando as configurações

Após toda e qualquer alteração, é necessário reiniciar os processos.

* systemctl restart smbd.service
* systemctl restart nmbd.service
* systemctl restart syslog

## Habilitando automação através do cron

* crontab -e

** 0 0 * * 7 /home/servidor/Documentos/rotina_backup.sh
