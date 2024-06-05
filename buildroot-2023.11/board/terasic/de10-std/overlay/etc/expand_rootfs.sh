#!/bin/bash
#Expand Root Filesystem Script
#ejc - 2022
#STM32MP157A-DK1 Board
#
#
echo "Attempting Expand Rootfs..."
echo "Checking Enable File..."

FILE=/etc/expand_rootfs_en
if test -f "$FILE"; then
    echo "$FILE exists! - Going to expand root filesystem..."
	fdisk /dev/mmcblk0 <<EOF
p
d
4
n
4
4954

y
x
A
4
r
p
w
EOF
rm /etc/expand_rootfs_en
resize2fs /dev/mmcblk0p4
else
	echo "File NOT found! - Skipping expansion of root filesystem..."
fi