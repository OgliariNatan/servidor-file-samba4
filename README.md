# Repositório com arquivos de configuração do servidor de arquivos.

Um pequeno manual de como configurar um servidor de arquivos com acesso por user&password com o <a href="https://www.samba.org/"> <img src="https://img.shields.io/badge/-SAMBA-violet"/> </a>.


### Autorizar as porta e instalando o ssh

* <code>sudo apt install openssh-server</code>
* <code>sudo service ssh start</code>
* <del> <code>ufw allow ssh </del> | ufw allow 22</code> #porta do samba (22)

## Alterando a porta ssh

* <code> nano /etc/ssh/sshd_config</code>
* alterar a linha Port xx (nova porta)
* <ins> <code>ufw allow xx</code> </ins> (nova porta)
* <code>ufw deny 22</code>
* <code>service sshd restart</code>

## smb.conf

Arquivo de configuração do samba.

## Adicionando usuários

Cria-se usuários normais no <img src="https://img.shields.io/badge/-LINUX-brightgreen" /> e adiciona ao <img src="https://img.shields.io/badge/-SAMBA-violet"/>.

* <code>sudo useradd [nome_usuario]</code> &#8680; Cria usuario no linux.
* <code>sudo smbpasswd -a [nome_usuario]</code> &#8680; add usuários ao <img src="https://img.shields.io/badge/-SAMBA-violet"/> e especifica uma senha
* <code>sudo smbpasswd -U [nome_usuario]</code> &#8680; Altera senha <img src="https://img.shields.io/badge/-SAMBA-violet"/>
###################################################################
<details>
<summary>📈 Alterando o arquivo $sudoers </summary>

Defaults secure_path="/usr/local/sbin:.....:ADD_DIR_SCRIPTY"
<p> user ALL=(ALL:ALL) ALL &#8680; add_user </p>


</details>

###################################################################
## add_user_samba.sh

<p> Scripty para adicionar usuários ao samba </p>

## rotina_backup.sh

Implementação de uma rotina de uma automação de backup de arquivos compartilhados com o samba. </br>
<code> /media/servidor/backup </code> &#8680; Diretório da pasta backup. </br>
<b> <code> chmod u+x rotina_backup.sh </code> &#8680; Habilita o scripty como executável. </br> </b>
<b> <code> chown root:root rotina_backup.sh </code> &#8680; Muda o dono do arquivo e executa com root. </br> </b>

## auditsamba.conf

Arquivo que irá conter as especificações para a auditoria e o local do registro.

Criar um arquivo em:
* <code>/etc/rsyslog.d/auditsamba.conf</code>


## Para apagar os registro de LOGIN no WIN

* <code>net use * /delete /y</code>


## Para auditoria em tempo real

* <code>tail -f /var/log/syslog</code>

## Testando a configuração do <img src="https://img.shields.io/badge/-SAMBA-violet"/>

* <code>testparm</code> &#8680; Realiza o teste do arquivo smb.conf

## Reiniciando as configurações

Após toda e qualquer alteração, é necessário reiniciar os processos.

* <code> sudo systemctl restart smbd.service</code>
* <code> sudo systemctl restart nmbd.service</code>
* <code> sudo systemctl restart syslog</code>

## Autorizando a execução do arquivo de rotina_backup.

* <code>crontab -e</code>

 0 0 * * 7 /home/servidor/Documentos/rotina_backup.sh </br>
ctrl+o &#8680; Salva o arquivo cro

 ## Para verificação na máquina

 * <code>df -h</code> &#8680; Uso da ROM
 * <code>du -h pasta</code> &#8680; Tamanho da pasta

 ## Para montar discos

 * <code>sudo fdisk -l </code> &#8680; Lista os discos com o caminho
 * <del> <code> lsblk </code> &#8680; Lista os discos na máquina </del>
 * <code>sudo mount /caminho_do_disco /caminho_da_pasta_a_ser_montada</code>

 ## Ver última reiniciação

 * <code> who -b </code> &#8680; Última inicialização do sistema.
 * <code> uptime -p </code> &#8680; Tempo de operação.
