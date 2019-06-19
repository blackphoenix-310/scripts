#!/bin/bash
# Showing remote services, ports, and OS
# on enumerated host(s)

echo "Script will create and copy nmap.xsl to nscans destination."
echo "This is necessary to read xml correctly in a browser."

if [ ! -d ~/nscans ]
then
	mkdir ~/nscans
fi

if [ ! -b ~/nscans/nmap.xsl ]
then
 	cp /usr/share/nmap/nmap.xsl ~/nscans/nmap.xsl
fi

if [ $# -ne 1 ]
then
        echo "Usage: ./nmap-xml.sh HOST IP/IP-RANGE"
        exit 1
fi

echo "Scanning host(s) ${1}"

read -p "Set file name and location for xml file (will generate .xml extension): " FI

nmap -O -sC -sV -n -oX ~/nscans/${FI}.xml --stylesheet=nmap.xsl --open --reason ${1}
