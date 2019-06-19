#!/bin/bash

if [ $# -ne 1 ]; then
        echo "Usage: ./remote-services.sh TARGET-IP"
        exit 1
fi
echo
echo "Enumerating remote services on host(s) ${1}"
echo

nmap -Pn -sS -F -n -vv -sV --reason --open ${1}

