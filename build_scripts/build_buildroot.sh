#!/bin/bash
#
#Build buildroot for DE10-Standard Cyclone V SoC FPGA
#ejc-01.07.2024
#Last updated: 01.07.2024
#
##################################################
#Deactivate the perl extentions if needed...
##################################################
#eval $(perl -Mlocal::lib=--deactivate-all)
##################################################
#Check for necessary programs...
##################################################
bash ./prerequisite_check.sh
##################################################
#Making version numbers...
##################################################
echo "Making Versions..."
bash ./motd_script.sh
##################################################
#Change directory to buildroot, clean and make...
##################################################
echo "Making buildroot..."
cd ../buildroot-2023.11
echo "Running make clean..."
make clean
echo "Done cleaning..."
echo "Building..."
make
echo "Done processing build! - No error checking from buildroot exists...check for errors."
echo "Go burn sd card after build..."