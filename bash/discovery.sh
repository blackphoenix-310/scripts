#!/bin/bash

if [ $# -ne 1 ]; then
	echo "Usage: ./discovery.sh TARGET-IP-RANGE"
	echo "Ex: ./port-scan.sh 192.168.1.0/24"
	echo "or ./port-scan.sh 192.168.1.0-50"
	exit 1
fi

echo ""
echo "Scanning subnet ${1}"
echo "Excluding $(hostname)"

nmap -sn -n -v --reason --open --exclude $(hostname) ${1}
