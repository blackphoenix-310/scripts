#!/bin/bash

if [ $# -ne 1 ]; then
        echo "Usage: ./port-scan.sh TARGET-IP-RANGE"
		echo "Ex: ./port-scan.sh 192.168.1.0/24"
		echo "or ./port-scan.sh 192.168.1.0-50"
        exit 1
fi

echo ""
echo "Scanning ports at ${1}"

nmap -e eth0 -Pn -sS -F -n -vv --reason --open --exclude $(hostname -i) ${1}
