#!/bin/bash
#
#ejc-01.07.2024
#Last updated: 01.07.2024
#Pre build script to embed version with buildroot image as Linux MOTD
#Buildroot Version Numbering
build=$(cat build)
((build++))
echo $build > build

echo "Making MOTD..."
echo "Going back to find version numbers in buildroot..."
cd ../buildroot-2023.11/
#Version Variables
kernelversion=$(cat .config | grep KERNEL_VERSION | sed 's/.*"\(.*\)"[^"]*$/\1/')
ubootversion=$(cat .config | grep UBOOT_VERSION | sed 's/.*"\(.*\)"[^"]*$/\1/')
bareboxversion=$(cat .config | grep BAREBOX_VERSION | sed 's/.*"\(.*\)"[^"]*$/\1/')
build=$(cat ../build_scripts/build)
major="0"
minor="1"
#gitHEAD=$(git rev-parse HEAD) #uncomment once git initialized


#Go back overlay area
echo "Going back to overlay/etc area"
cd board/terasic/de10-std/overlay/etc

#Make the motd file itself
echo "" > motd
echo "" >> motd
echo "*****************************************" >> motd
echo "This software is licensed under" >> motd
echo "GNU GENERAL PUBLIC LICENSE" >> motd
echo "GPL V2, June 1991">> motd
echo "You are free to use and re-distribute" >> motd
echo "but there is no implied warranty by any" >> motd
echo "of the developers of this software or any" >> motd
echo "of the software contained within." >> motd
echo "This is a development platflorm for" >> motd
echo "Altera Cyclone V SoC FPGA development boards" >> motd
echo "*****************************************" >> motd
echo "" >> motd
echo "************************************************************************************" >> motd
echo " ____  _____ _  ___       ____  _                  _               _ " >> motd
echo "|  _ \| ____/ |/ _ \     / ___|| |_ __ _ ____   __| | ____ ____ __| |" >> motd
echo "| | | |  _| | | | | |____\___ \| __/ __ |  _ \ / _  |/ _  |  __/ _  |" >> motd
echo "| |_| | |___| | |_| |_____|__) | || (_| | | | | (_| | (_| | | | (_| |" >> motd
echo "|____/|_____|_|\___/     |____/ \__\____|_| |_|\____|\____|_|  \__,_|" >> motd
echo "                                                                     " >> motd
echo "************************************************************************************" >> motd
echo "" >> motd
echo "***************************************************" >> motd
echo "Welcome to the DE10-Std Cyclone V Buildroot Image" >> motd
echo "Version: $major.$minor.$build" >> motd
echo "Github ID: $gitHEAD" >> motd
echo "Build Date: "$(date -u) >> motd
echo "Build Machine: "$(hostname) >> motd
echo "Linux Kernel: $kernelversion" >> motd
#echo "U-Boot: $ubootversion" >> motd
echo "Barebox: $bareboxversion" >> motd
echo "Arch: ARMv7-A - Cortex A9" >> motd
echo "***************************************************" >> motd
echo "" >> motd
echo "" >> motd
cd ../../../../../../build_scripts
echo "Done!"