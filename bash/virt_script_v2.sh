#!/bin/bash

NAME=$1
STORE_SIZE=$2
STORE=$3
POOL_NAME=$4
ISO_PATH=$5

if [ ! -f /mnt/guest_store/$NAME ]; then
  virsh vol-create-as --pool ${POOL_NAME} --name ${NAME} --capacity ${STORE_SIZE}G --format qcow2
  virt-install \
 --name $NAME \
 --memory 2048 \
 --vcpus 2 \
 --boot hd,cdrom,network,uefi,menu=on \
 --disk path=/mnt/guest_store/${NAME} \
 --cdrom $ISO_PATH \
 --network bridge=br0 \
 --graphics spice,listen='172.16.30.123' \
 --os-type linux \
 --os-variant centos7.0 \
 --noautoconsole &
else
  virt-install \
   --name $NAME \
   --memory 2048 \
   --vcpus 2 \
   --disk path=/mnt/guest_store/${NAME} \
   --network bridge=br0 \
   --graphics spice,listen='172.16.30.123' \
   --os-type linux \
   --os-variant centos7.0 \
   --noautoconsole \
   --import &
fi
