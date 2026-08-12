# Repositório com arquivos de configuração do servidor de arquivos.

Um pequeno manual de como configurar um servidor de arquivos com acesso por user&password com o <a href="https://www.samba.org/"> <img src="https://img.shields.io/badge/-SAMBA-violet"/> </a>.
<img src="https://img.shields.io/badge/Feito%20-Bash-1f425f.svg"/>

### Autorizar as porta e instalando o ssh

* <code>sudo apt install openssh-server</code>
* <code>sudo service ssh start</code>
* <del> <code>ufw allow ssh </del> | ufw allow 22</code> #porta do samba (22)

## Alterando para IP estático, no ubuntu server 22.04 📋 🏥
* Altere o arquivo ```cd /etc/netplan/```
* antes de qualquer coisa crie um backup do arq existente.
* ``` sudo cp *.yaml *.yam.old```
* Após abra o arquivo:
*  ```sudo nano *.yaml```
em exemplo de como ficará:
``` shell
 # This is the network config written by 'subiquity'
network:
   version: 2
   renderer: networkd
   ethernets:
      enp2s0:
         dhcp4: false
         dhcp6: no
         addresses: [20.40.22.1/24]
         routes:
             - to: default
               via: 20.40.22.254
         #gateway4: 20.40.22.254
         nameservers:
            addresses: [8.8.8.8,8.8.4.4]
```
[ ] Cuide da identação, que deverá se com **espaços** em vez de **tab**. <br>
[ ] Observe que o comando __gateway4:__ é obsoleto em vez disso utilize o **routes:**.
#### Aplicando alteração
* Testendo a sintexe do arquivo
  ```
  sudo netplan try
  ```
* Aplicando as configurações

  ```
  sudo netplan apply
  ```
* Verificando as configurações

  ```
  ip addr show
  ```
## Alterando a porta ssh

* <code> nano /etc/ssh/sshd_config</code>
* alterar a linha Port xx (nova porta)
* <ins> <code>ufw allow xx</code> </ins> (nova porta)
* <code>ufw deny 22</code>
* <code>service sshd restart</code>

## smb.conf

Arquivo de configuração do samba.

## Adicionando usuários

Cria-se usuários normais no <img src="https://img.shields.io/badge/-LINUX-brightgreen" /> e adiciona ao <img src="https://img.shields.io/badge/-SAMBA-violet"/>. <br>
pdbedit -L -v | grep username <br>
* <code>sudo useradd [nome_usuario]</code> &#8680; Cria usuario no linux.
* <code>sudo smbpasswd -a [nome_usuario]</code> &#8680; add usuários ao <img src="https://img.shields.io/badge/-SAMBA-violet"/> e especifica uma senha
* <code>sudo smbpasswd -U [nome_usuario]</code> &#8680; Altera senha <img src="https://img.shields.io/badge/-SAMBA-violet"/>
* <p> <code> smbpasswd -x [NAME_USER] </code> Exclui usuário </p>
<details>
<summary> Curiosidade </summary>
<p> <code> sudo adduser --no-create-home --disabled-login {NAME_USER} </code> </p>
<p> <code> usermod -e [data_expiração AAAA-MM-DD] [NAME_USER] </code> </p>
 <p> <code> sudo chage -l [NAME_USER] </code> &#8680; Verifica se posui a expiração da conta. </p>
<p> <code> sudo chage -E [AAAA-MM-DD] [NAME_USER] </code> &#8680; Configura a expiração da conta. </p>
<p> <code>usermod -aG [nome_do_grupo] [nome_do_usuário_que_deseja_adicionar_ao_grupo] </code> </p>
<p> <code> pdbedit -L -v | grep username </code> &#8680; Lista usuarios </p>



 #### Grupos  
<p> <code> sudo cat /etc/group </code>  &#8680; Lista os grupo </p> 
 <p> <code> sudo grupoadd samba </code>  &#8680; Cria o grupo </p> 
 <p> <code> sudo chown -R servidor:samba /dir_com </code> </p>
 <p> <code> sudo usermod -aG grupo1,grupo2 usuario </code>  &#8680; Adiciona em varios grupos </p> 
 <p> <code> sudo groups usuario </code>  &#8680; Verifica os grupos membros </p>
</details>

<details>
<summary> Alterando o arquivo $sudoers </summary>
<code> sudo visudo </code> </br>
Defaults lecture="never"</br>
Defaults lecture_file="/docs/lecture/msg.txt"</br>


Defaults secure_path="/usr/local/sbin:.....:ADD_DIR_SCRIPTY"
<p> user ALL=(ALL:ALL) ALL &#8680; add_user </p>
<p> user ALL=NOPASSWD:/home/servidor/Documentos/rotina_backup.sh, /home/servidor/Documentos/delete_file_olds.sh &#8680; Executa estes scripty se a solicitação da senha. </p>

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

* ```tail -f /var/log/syslog```
  
## Testando a configuração do <img src="https://img.shields.io/badge/-SAMBA-violet"/>

* <code>testparm</code> &#8680; Realiza o teste do arquivo smb.conf

## Reiniciando as configurações

Após toda e qualquer alteração, é necessário reiniciar os processos.

```shell
sudo systemctl restart smbd.service
sudo systemctl restart nmbd.service
sudo systemctl restart syslog
```

## Autorizando a execução do arquivo de rotina_backup.

* <code>crontab -e</code>

 0 0 * * 7 /home/servidor/Documentos/rotina_backup.sh </br>
 0 0 * * 7 /home/servidor/Documentos/delete_file_olds.sh </br> &#8680; use sudo crontab -e
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

   ### Para melhoria

   O backup esta sendo realizado pelo tar, implementar com o rync
 * diario, atualiza
 ```shell
 rsync -artvu /dir_origem /dir_destino
 ```
 * semanal 🌐
  ```shell
    rsync -ar /dir_origem /dir_destino 
  ```

 ```shell
     rsync -a -r -v usuario@IP:home/servidor/Área\ de\ Trabalho/Compartilhamento/ /home/servidor/Compartilhados/
 ```
   * Para VER:::
     <code>  rsync -ar --delete --backup --backup-dir=/dir_backup /dir_origem /dir_destino </code>

 ```shell

### Alguns ajuste de segurança a ser implementado.
```
# Calcular hash SHA256 do script
HASH=$(sha256sum ~/backup_protegido.sh | cut -d' ' -f1)

echo "Hash do script:"
echo "$HASH"

# EDITE o script e coloque este hash na variável EXPECTED_HASH
echo ""
echo "Atualize a linha no script com:"
echo "EXPECTED_HASH=\"$HASH\""
```
    tar -tvf /dir_arq/name_bk.tar.gz 
  ```
