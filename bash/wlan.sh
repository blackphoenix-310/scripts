#!/bin/bash

WLAN_UP=$(ip link set wlan0 up)
ASSOCIATE=$(iwconfig wlan0 essid *enter ESSID*)




$WLAN_UP
sleep 3
$ASSOCIATE
