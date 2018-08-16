#!/bin/bash

clear
read -p "Which system? " box


case "$box" in
  
  [rR]amuh)
   ssh -c aes256-cbc cisco@172.16.30.90
   ;;
  
  [cC]arbunkl)
   ssh root@carbunkl.phoenix.org
   ;;
    
  [cC]ave)
   ssh rev@cave.phoenix.org
   ;;
    
  [cC]hocobo)
   ssh choco@chocobo.phoenix.org
   ;;
    
  [dD]oomtrain)
   ssh hades@doomtrain.phoenix.org
   ;;
    
  [gG]ilgamesh)
   ssh edge@gilgamesh.phoenix.org
   ;;
  
  [iI]frit)
   ssh rodgort@ifrit.phoenix.org
   ;;
    
  [jJ]anus)
   ssh glassman@janus.phoenix.org
   ;;

  [lL]eviathan)
   ssh squirtle@leviathan.phoenix.org
   ;;
     
  [pP]hoenixcave)
   ssh odin@phoenixcave.phoenix.org
   ;;
  
  [sS]hiva)
   ssh frostfang@shiva.phoenix.org
   ;;
   
  [sS]iren)
   ssh banshee@siren.phoenix.org
   ;;
   
esac
