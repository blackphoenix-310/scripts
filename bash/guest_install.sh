#/bin/bash

###Information Functions###
vol_info () {
read -p "Pool destination: " POOL_NAME
read -p "Volume name: " VOL_NAME
read -p "Capacity in gigabytes ending with (G): " DISK_SIZE
virsh vol-create-as --pool $POOL_NAME --name $VOL_NAME --format qcow2 --capacity $DISK_SIZE
}

install_info () {
read -p "Guest name: " VM_NAME
read -p "# of vCPUs: " CPU
read -p "Memory amount (in MiB): " MEM
read -p "Path to storage: " STORE
}

###Installation Functions###
kubuntu () {
vol_info
install_info
virt-install --name $VM_NAME --vcpu $CPU --ram $MEM \
--disk path=$STORE \
--cdrom=/opt/kubuntu-18.04.1-desktop-amd64.iso \
--os-type linux \
--os-variant ubuntu16.04 \
--network network=gateway \
--graphics spice,listen='172.16.30.125' \
--noautoconsole &
}

suse-tumble () {
vol_info
install_info
virt-install --name $VM_NAME --vcpu $CPU --ram $MEM \
--disk path=$STORE \
--cdrom=/opt/openSUSE-Tumbleweed-DVD-x86_64-Snapshot20190108-Media.iso \
--os-type linux \
--os-variant opensusetumbleweed \
--network network=gateway \
--graphics spice,listen='172.16.30.125' \
--noautoconsole &
}

centos_7 () {
vol_info
install_info
virt-install --name $VM_NAME --vcpu $CPU --ram $MEM \
--disk path=$STORE \
--cdrom=CentOS-7-x86_64-DVD-1810.iso \
--os-type linux \
--os-variant centos7.0 \
--network network=gateway \
--graphics spice,listen='172.16.30.125' \
--noautoconsole &
}

ubuntu_server_bionic () {
vol_info
install_info
virt-install --name $VM_NAME --vcpu $CPU --ram $MEM \
--disk path=$STORE \
--cdrom=/opt/ubuntu-18.04.1-live-server-amd64.iso \
--os-type linux \
--os-variant ubuntu18.04 \
--network network=gateway \
--graphics spice,listen='172.16.30.125' \
--noautoconsole &
}

deb9 () {
vol_info
install_info
virt-install --name $VM_NAME --vcpu $CPU --ram $MEM \
--disk path=$STORE \
--cdrom=/opt/debian-9.6.0-amd64-DVD-1.iso \
--os-type linux \
--os-variant debian9 \
--network network=gateway \
--graphics spice,listen='172.16.30.125' \
--noautoconsole &
}

win_10 () {
vol_info
install_info
virt-install --name $VM_NAME --vcpu $CPU --ram $MEM \
--disk path=$STORE \
--cdrom=/opt/<window10_iso> \
--os-type windows \
--os-variant win10 \
--network network=gateway \
--graphics spice,listen='172.16.30.125' \
--noautoconsole &
}

win_2k12 () {
vol_info
install_info
virt-install --name $VM_NAME --vcpu $CPU --ram $MEM \
--disk path=$STORE \
--cdrom=/opt/<windows2k12_iso> \
--os-type windows \
--os-variant w2k12 \
--network network=gateway \
--graphics spice,listen='172.16.30.125' \
--noautoconsole &
}

serv_2k16 () {
vol_info
install_info
virt-install --name $VM_NAME --vcpu $CPU --ram $MEM \
--disk path=$STORE \
--cdrom=/opt/<windows2k16_iso> \
--os-type windows \
--os-variant w2k16 \
--network network=gateway \
--graphics spice,listen='172.16.30.125' \
--noautoconsole &
}
