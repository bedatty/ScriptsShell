#! /usr/bin/env bash

username="";
opcao="";

Principal() {
 echo "Opções:"
   echo
   echo "1. List users"
   echo "2. Search a user"
   echo "3. Add users"
   echo "4. Delete users"
   echo "5. Exit"
   echo
   echo -n "What's your option: "
   read -re opcao
   case "$opcao" in
     1) list_users ;;
     2) search_user ;;
     3) add_user ;;
     4) delete_user ;;
     5) exit ;;
     *) "Unknow option" ; echo ; Principal ;;
   esac
}

#Functions

list_users() {
   clear

   #docker run --rm -it -v $OVPN_DATA:/etc/openvpn kylemanna/openvpn ovpn_listclients
   docker exec VPN_AD ovpn_listclients

   Principal
}

search_user() {
  echo -n "Informe o usuário: "
  read -re username

  #docker run --rm -it -v $OVPN_DATA:/etc/openvpn kylemanna/openvpn ovpn_listclients | grep $username
  docker exec VPN_AD ovpn_listclients | grep "$username"
  Principal
}

add_user() {
  clear

  echo -n "Informe o usuário: "
  read -re username

  #docker run -v $OVPN_DATA:/etc/openvpn --rm -it kylemanna/openvpn easyrsa build-client-full $username nopass
  docker exec -it VPN_AD easyrsa build-client-full "$username" nopass
  echo "Usuário $username adicionado."
  #docker run -v $OVPN_DATA:/etc/openvpn --rm kylemanna/openvpn ovpn_getclient $username > $username.ovpn
  docker exec VPN_AD ovpn_getclient "$username" > "$username".ovpn
  Principal
}

delete_user() {

  echo -n "Informe o usuário: "
  read -re username

  #docker run --rm -it -v $OVPN_DATA:/etc/openvpn kylemanna/openvpn ovpn_revokeclient $username remove
  docker exec -it VPN_AD ovpn_revokeclient "$username" remove
  Principal
}

Principal