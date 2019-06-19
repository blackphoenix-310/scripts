#!/bin/bash
#set -xv

# script logging
exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>log.out 2>&1

# variables
LIST_GUEST=$(virsh -c qemu:///system list | awk '/running/{print $2}') # list running guests
BLK_LIST=$(virsh -c qemu:///system domblklist | awk '/vda/{print $2}') # list blk devices to backup
SNAP_DEST=/mnt/snap/
CPY_DEST=/mnt/backup/

for n in $LIST_GUEST
do
 echo "Creating external snap of ${n}..."
 virsh -c qemu:///system snapshot-create-as --domain ${n} --name ${n} --diskspec vda,file=${SNAP_DEST}${n}.qcow2 \
 --disk-only --atomic --no-metadata --quiesce
 echo "Copying ${n}'s storage...."
 cp $BLK_LIST ${CPY_DEST}${date +%F_%R}
 echo "Merging current ${n}'s snapshot..."
 virsh -c qemu:///system blockcommit --domain ${n} vda --active --pivot --verbose
 rm -rf ${SNAP_DEST}${n}.qcow2
 echo "Backup of ${n} created and changes merged"
done


# find active blockdevices <virsh domblklist $LIST_GUEST>
# create external disk snapshot <virsh -c qemu:///system snapshot-create-as --domain <vm_name> --name <vm_name> --diskspec vda,file=/path/to/external.qcow2 --disk-only --no-metadata --atomic --quiesce>
# copy/rsync to backup storage <rsync -az /path/of/external/ /path/to/backup>
# merge contents of external snap with live vm <virsh -c qemu:///system blockcommit --domain <vm_name> vda --active --pivot --verbose>
