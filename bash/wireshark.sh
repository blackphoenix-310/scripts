#!/bin/bash
#set -xv
clear
echo "This script will install Wireshark for a few distros using a distro ID."
echo "If already know your disto ID you can continue"
echo "with the install, if not, use Ctrl+c to exit and run the" 
echo "cat /etc/os-release | grep ID= command"
echo "to find your distro ID. Not all distros are compatible with this"
echo "script. Change usernames within script to reflect your user(s)"
echo "Feel free to edit it as needed."

read -p "Enter distro ID: " ID
read -p "Enter username: " USE

case "$ID" in 
	[uU]buntu|[dD]ebian)
		
		echo "Will now install and configure Wireshark"
		echo "Press [Enter] to continue..."	
		apt-get -y install wireshark && usermod -a -G wireshark $USE
		chgrp wireshark /usr/bin/dumpcap
		chmod 755 /usr/bin/dumpcap
		setcap cap_net_raw,cap_net_admin=eip /usr/bin/dumpcap
		echo "User must log out then back in to"
		echo "to see interfaces after installation"

		;;

	[aA]rch)

		echo "Will now install and configure Wireshark"
		echo "Press [Enter] to continue..."
		pacman -S wireshark-qt wireshark-cli && gpasswd -a $USE wireshark
		echo "User must log out then back in to"
		echo "to see interfaces after installation."

		;;

	[fF]edora|[cC]entos)
		echo "Will now install and configure Wireshark"
		echo "Press [Enter] to continue..."
		yum install wireshark -y && usermod -a -G wireshark $USE
		echo "User must log out then back in to"
		echo "to see interfaces after installation."

		;;
	*)

		echo "Unknown OS.."
		exit 0

 		;;

esac
