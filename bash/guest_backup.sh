#!/bin/bash
#set -xv

# Script to do live KVM guest backup
# using Active block commit

# declare/initialize global array
guests=($(virsh -c qemu:///system list | awk '/running/{print $2}'))

# global variables
SNAP_DEST=/mnt/snap/
CPY_DEST=/mnt/backup/

for n in "${guests[@]}"
do
 # initialize block storage array list and sets array variable
 blks=($(virsh -c qemu:///system domblklist --domain ${n} | awk '/vda/{print $2}'))
 BLK_CALL=$(echo ${blks[0]})
 # create external snapshot
 virsh -c qemu:///system snapshot-create-as --domain ${n} --name ${n} --diskspec vda,file=${SNAP_DEST}${n}.qcow2 \
 --disk-only --atomic --no-metadata --quiesce | logger -t guest_snap
 # syncs with backup destination
 rsync -azq ${BLK_CALL} ${CPY_DEST}${n} | logger -t guest_sync
 # active blockcommit
 virsh -c qemu:///system blockcommit --domain ${n} vda --active --pivot --verbose | logger -t guest_pivot
 rm -rf ${SNAP_DEST}${n}.qcow2
 
done
