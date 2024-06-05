#!/bin/bash
#
#Make new backup
#ejc-01.07.2024
#Last updated: 01.07.2024
#
creation_date=$(date +%m.%d.%Y)
version=$(grep Version ../buildroot-2023.11/board/terasic/de10nano_cyclone5/overlay/etc/motd | sed 's/^.*[^0-9]\([0-9]*\.[0-9]*\.[0-9]*\).*$/\1/')
cd $HOME/backups
mkdir de10std_${version}_backup_${creation_date} && cd "$_"
echo "Backup Date: "$(date -u) > info.txt
echo "Machine Name: "$(hostname) >> info.txt
echo "User: "$(whoami) >> info.txt
echo "Version: "${version} >> info.txt
cd ../../de10_std
tar -czvf de10std_backup_${creation_date}.tar.gz *
mv de10std_backup_${creation_date}.tar.gz $HOME/backups/de10std_${version}_backup_${creation_date}
echo "Done"