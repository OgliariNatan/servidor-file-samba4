# Repositorio com arquivos de configuração do servidor de arquivos.

Um pequeno manual de como configurar um servidor de arquivos com acesso por user&password com o <a href="https://www.samba.org/"> <img src="https://img.shields.io/badge/-SAMBA-violet"/> </a>.


### Autorizar as porta

*ufw allow ssh | ufw allow 22 #porta do samba (22)


## smb.conf

Arquivo de configuração do samba.

## Adicionando usuários

Cria-se usuários normais no <img src="https://img.shields.io/badge/Linux-E34F26?style=for-the-badge&logo=linux&logoColor=black" /> e adiciona ao samba.

* useeradd [nome_usuario] => Cria usuario no linux.
* smbpasswd -a [nome_usuario] => add usuários ao SAMBA e especifica uma senha
* smbpasswd -U [nome_usuario] => Altera senha SAMBA

## rotina_backup.sh

Implementação de uma rotina de uma automação de backup de arquivos compartilhados com o samba.

## auditsamba.conf

Arquivo que irá conter as especificações para a auditoria e o local do registro.

Criar um arquivo em:
* /etc/rsyslog.d/auditsamba.conf


## Para apagar os registro de LOGIN no WIN

* net use * /delete /y


## Para auditoria em tempo real

* tail -f /var/log/syslog

## Testando a configuração do SAMBA

testparm => Realiza o teste do arquivo smb.conf

## Reiniciando as configurações

Após toda e qualquer alteração, é necessário reiniciar os processos.

* systemctl restart smbd.service
* systemctl restart nmbd.service
* systemctl restart syslog

## Autorizando a execução do arquivo de rotina_backup.

* crontab -e

 0 0 * * 7 /home/servidor/Documentos/rotina_backup.sh
