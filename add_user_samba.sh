#!/bin/sh #interpretador bash
#####	NOME:				add_user_samba.sh
#####	VERSÃO:				0.1
#####	DESCRIÇÃO:			Implementação de scripty para adicionar usuarios samba
#####	DATA DA CRIAÇÃO:	29/03/2023
#####	ESCRITO POR:		Natan Ogliari
#####	E-MAIL:				natanogliari@gmail.com
#####	DISTRO:				Ubuntu GNU/Linux 22.04
#####	LICENÇA:			MIT license
#####	PROJETO:			https://github.com/OgliariNatan/servidor-file-samba4
#########################Torne o scripty executavél ##########
## chmod u+x novo_script
##############################
######### / Função de reiniciação dos serviços associados ao samba
function restart_servicos {
  #statements
  sudo systemctl restart smbd.service #Reinicia o samba
  sudo systemctl restart nmbd.service #Reinicia o NT
  sudo systemctl restart syslog #Reinicia o sistema de log
  clear
  #testparm #Testa o samba, e exibe o resultado
}

############### / fim função de reiniciação



echo "Bem vindo a criação ou remoção de usuários samba"
echo "Para Adicionar um usuário digite (1)."
echo "Para alterar uma SENHA de um usuário digite (2)."
echo "Para Remover um usuário digite (3)."
echo "Para sair digite (4)."
read id_status

case "$id_status" in
  1)
    echo "Escolheu a incerção de um novo usuário."
    echo "Digite o nome do usuário:"
    read new_user
    sudo useradd $new_user #Cria usuario LINUX
    echo -e "Digite uma senha para o: \n $new_user"
    sudo smbpasswd -a $new_user #Associa user ao samba e especifica uma senha
    restart_servicos
    sleep 5
  ;;
  2)
    echo "Escolheu a alteração de senha."
    echo "Usuarios cadastrados."
    sudo pdbedit -L
    #echo "Digite o usuário a ser redifinido a senha."
    #read user_new_passwd
    read -p "Digite o usuário a ser redifinido a senha."user_new_passwd
    sudo smbpasswd -U $user_new_passwd
    restart_servicos
  ;;
  3)
    echo "Escolheu a remoção de usuários."
    echo "Usuarios cadastrados."
    sudo pdbedit -L
    echo  "Digite o usuário a ser removido."
    read remov_user
    sudo smbpasswd -x $remov_user
    sudo userdel -r $remov_user
    restart_servicos
  ;;
  4)
    restart_servicos
    exit 1
  ;;
  *)
    echo "Insira uma opção válida."
    exit 1 #encerra o programa
esac
unset id_status new_user user_new_passwd remov_user #Remove todas as variaveis criadas
echo "Concluído"
