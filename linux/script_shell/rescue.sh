#! /usr/bin/env bash

path="";
username="";

echo -e "Archive's name e.g (fulano.detal): "
read -r username
echo
echo -e "Put the path of your directory e.g (c/Users/fulano/): "
read -r path
echo
scp -i ".ssh/ovpn.pem" ec2-user@34.231.53.51:~/"$username".ovpn /mnt/"$path"/Desktop/