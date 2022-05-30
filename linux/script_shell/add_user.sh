#! /usr/bin/env bash

set -u

username="";
password="";

echo -n "Username: "
read -e username
getent passwd "$username" > /dev/null 2&>log    # testa se um usuario já existe, caso sim retorna '2'
_res=$?;

set -e;

## caso o usuario já exista no sistema,
## questionamos se a senha deve ser atualizada
if [ $_res -eq 0 ]; then
    echo -n "AVISO!! Usuário \"$username\" já existe!";
    read -r -p "Are you sure update the password? [y/N] " response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]];then
            #password=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9-_!@#$%&*+' | fold -w 20 | head -n1)
            password=$(tr -dc 'a-zA-Z0-9-_!@#$%&*+' < /dev/random | fold -w 20 | head -n1)
            echo "$username":"$password" | sudo chpasswd
            echo -e "\nUser's password $username has been changed\n$password"
    else
            exit
    fi
else
## caso o usuário não exista,
## criar um novo
    sudo adduser --system --no-create-home "$username"
    #password=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9-_!@#$%&*+' | fold -w 20 | head -n1)
    password=$(tr -dc 'a-zA-Z0-9-_!@#$%&*+' < /dev/random | fold -w 20 | head -n1)
    echo "$username":"$password" | sudo chpasswd
    echo -e "\nNovo user $username adicionado."
    echo -e "$username\n$password"
fi