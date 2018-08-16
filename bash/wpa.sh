#!/bin/bash


wpa_supplicant -B -iwlan0 -c/root/.home.conf
dhclient wlan0

