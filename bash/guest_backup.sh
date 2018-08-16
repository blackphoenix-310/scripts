#!/bin/bash
#set -xv

LIST_GUEST=$(virsh -c qemu:///system list | awk '/running/{print $2}') # list running guests
BACK_DEST=/var/lib/libvirt/images/vm_back_test/


for n in $LIST_GUEST
do
 echo "Dumping configuration and backing up storage for ${n}"
 virsh -c qemu:///system dumpxml ${n} > $BACK_DEST
 virsh -c qemu:///system snapshot-create-as --domain ${n} --name ${n} --diskspec vda,file=${BACK_DEST}${n}.qcow2 --disk-only --atomic
 virsh -c qemu:///system blockcommit --domain ${n} vda --active --pivot --shallow --verbose
 echo "Backup of ${n} created and changes merged"
done
