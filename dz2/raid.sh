#!/bin/bash
mdadm --zero-superblock --force /dev/sd{b,c,d,e,f}
mdadm --create --verbose --auto=yes /dev/md0 -l 10 -n 4 /dev/sd{b,c,d,e}
mkdir /etc/mdadm
echo "DEVICE partitions" > /etc/mdadm/mdadm.conf
mdadm --detail --scan --verbose | awk '/ARRAY/ {print}' >> /etc/mdadm/mdadm.conf
