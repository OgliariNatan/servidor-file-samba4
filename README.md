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

<details>
<summary>📈 Alterando o arquivo $sudoers </summary>
<svg xmlns="http://www.w3.org/2000/svg" x="0px" y="0px" width="10" height="10" viewBox="0 0 50 50">
<path d="M 46.792969 22.089844 L 27.910156 3.207031 C 27.109375 2.402344 26.054688 2 25 2 C 23.945313 2 22.890625 2.402344 22.089844 3.207031 L 18.355469 6.941406 L 22.976563 11.5625 C 24.511719 10.660156 26.511719 10.855469 27.828125 12.171875 C 29.144531 13.488281 29.335938 15.488281 28.433594 17.019531 L 32.976563 21.5625 C 34.511719 20.660156 36.511719 20.855469 37.828125 22.171875 C 39.390625 23.734375 39.390625 26.265625 37.828125 27.828125 C 36.265625 29.390625 33.734375 29.390625 32.171875 27.828125 C 30.855469 26.511719 30.660156 24.511719 31.5625 22.976563 L 27.019531 18.433594 C 26.695313 18.625 26.355469 18.765625 26 18.855469 L 26 31.140625 C 27.722656 31.585938 29 33.136719 29 35 C 29 37.210938 27.210938 39 25 39 C 22.789063 39 21 37.210938 21 35 C 21 33.136719 22.277344 31.585938 24 31.140625 L 24 18.855469 C 23.332031 18.683594 22.695313 18.351563 22.171875 17.828125 C 20.855469 16.511719 20.664063 14.511719 21.566406 12.980469 L 16.941406 8.355469 L 3.207031 22.089844 C 1.597656 23.695313 1.597656 26.304688 3.207031 27.910156 L 22.089844 46.792969 C 22.890625 47.597656 23.945313 48 25 48 C 26.054688 48 27.109375 47.597656 27.910156 46.792969 L 46.792969 27.910156 C 48.402344 26.304688 48.402344 23.695313 46.792969 22.089844 Z"></path>
</svg>
Defaults secure_path="/usr/local/sbin:.....:ADD_DIR_SCRIPTY"
<p> user ALL=(ALL:ALL) ALL &#8680; add_user </p>


</details>


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
