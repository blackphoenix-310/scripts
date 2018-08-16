#!/bin/bash
#set -xv

guest_info() {
read -p "Choose KVM host (URI or IP Address): " KVM_HOST
read -p "Guest name: " NAME
read -p "Set number of CPUs (integer): " CPU
read -p "Set RAM amount (integer): " RAM
read -p "Select location of disk: " DISK_LOC
echo "The command <osinfo-query os> will help you"
echo "find you OS variant. You can always mark it as generic"
echo "along with you OS type if you are not sure what your"
echo "variant is."
read -p "Do you need to find your OS variant? (y/n)" OS_Q
if [ "$OS_Q" == "y" ]
then
 osinfo-query os | less
fi
read -p "Set OS variant: " OS_V
read -p "Set OS type: " OS_T
}

run_again() {
read -p "Another option? (y/n) " CHO
if [ "$CHO" == "y" ]
then
 clear
 $0
else
 echo "Exiting..."
 exit 0
fi
}

list_guest() {
read -p "Enter host URI (or IP Address). " KVM_HOST
virsh -c qemu+ssh://root@${KVM_HOST}/system list --all
$0
}

list_pool() {
read -p "Enter host URI (or IP Address). " KVM_HOST
virsh -c qemu+ssh://root@${KVM_HOST}/system pool-list --all
$0
}

list_vol() {
read -p "Enter host URI (or IP Address). " KVM_HOST
read -p "Enter pool name. " POOL
virsh -c qemu+ssh://root@${KVM_HOST}/system vol-list --pool $POOL
$0
}

list_net() {
read -p "Enter host URI (or IP Address). " KVM_HOST
virsh -c qemu+ssh://root@${KVM_HOST}/system net-list --all
$0
}

migrate_guest() {
read -p "Is the guest running? (y/n) " RUN
if [ "$RUN" == "y" ]
then
 read -p "Select source host. " SRC_URI
 read -p "Select destination host. " DEST_URI
 read -p "Select domain. " DOM
 virsh -c qemu+ssh://root@${SRC_URI}/system migrate \
 --domain $DOM \
 --live \
 --p2p \
 --tunnelled \
 --desturi qemu+ssh://root@${DEST_URI}/system \
 --persistent \
 --undefinesource \
 --verbose
 run_again
else
 read -p "Select source host. " SRC_URI
 read -p "Select destination host. " DEST_URI
 read -p "Select domain. " DOM
 virsh -c qemu+ssh://root@${SRC_URI}/system migrate \
 --domain $DOM \
 --p2p \
 --offline \
 --desturi qemu+ssh://root@${DEST_URI}/system \
 --persistent \
 --undefinesource \
 --verbose
 run_again
fi
}

guest_install() {
guest_info
read -p "Is the installation local, network, or pxe? " ANS
if [ "$ANS" == "local" ]
then
 read -p "Set ISO path: " ISO
 virt-install --connect qemu+ssh://root@${KVM_HOST}/system \
 --name $NAME \
 --ram $RAM \
 --vcpus $CPU \
 --disk path=$DISK_LOC \
 --cdrom $ISO \
 --network bridge=br0 \
 --graphics spice \
 --os-type $OS_T \
 --os-variant $OS_V \
 --noautoconsole &
elif [ "$ANS" == "network" ]
then
read -p "Set net install location (nfs://host/path, http(s)://host/path, ftp://host/path): " LOC
 virt-install --connect qemu+ssh://root@${KVM_HOST}/system \
 --name $NAME \
 --vcpu $CPU \
 --memory $RAM \
 --disk $DISK_LOC \
 --os-type $OS_T \
 --os-variant $OS_V \
 --location=$LOC \
 --network bridge=br0 \
 --graphics spice \
 --noautoconsole &
elif [ "$ANS" == "pxe"  ]
then
 virt-install --connect qemu+ssh://root@${KVM_HOST}/system \
 --name $NAME \
 --ram $RAM \
 --vcpus $CPU \
 --disk path=$DISK_LOC \
 --pxe \
 --network bridge=br0 \
 --graphics spice \
 --os-type $OS_T \
 --os-variant $OS_V \
 --noautoconsole &
fi
}

echo "============================"
echo "KVM/QEMU Virtual Management"
echo "============================"
echo
echo "This script will aid in management of KVM guests"
echo "Use the list options to find pools, storage, and guests"
echo "before trying to migrate, install, or backup any guests."
echo "Choose an option below to begin"
echo
echo
echo "1). List all Guests on KVM Host."
echo "2). List available host pools."
echo "3). List available volumes in host pools."
echo "4). List available networks."
echo "5). Install a KVM Guest."
echo "6). Migrate a KVM Guest."
echo
read -p "Select an option: " OPT

case "$OPT" in
    
    1) list_guest
       ;;
    
    2) list_pool
       ;;
      
    3) list_vol
       ;;
    
    4) list_net
       ;;
       
    5) guest_install
       ;;
    
    6) migrate_guest
       ;;
       
    *)
      echo "Invalid option..."
      echo "Choose a valid option"
      ;;
      
esac
