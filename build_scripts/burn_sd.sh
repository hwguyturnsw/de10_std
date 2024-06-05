#!/bin/bash
#
#Write SD card for DE10-Standard Cyclone V SoC FPGA buildroot image and auto resize the rootfs at image write time.
#ejc-01.07.2024
#Last updated: 01.07.2024
##################################################
#Check for root or sudo access...
##################################################
if ! id | grep -q root; then
	echo "Must be run as root"
	exit
fi
##################################################
#Check for necessary programs...
##################################################
echo "Checking Prerequisites..."
echo -ne '[=                    ](0%)\r'
if rpm -qa | grep "fdisk" 1> /dev/null ; then
	echo -ne '[=====                ](14.2%)\r'
else
	echo "fdisk not found...install fdisk and come back later..."
	echo "You could still use dd manually and fill in the following information."
	echo "sudo dd if=output/images/sdcard.img of=/dev/sdX"
	exit
fi
if which mkfs 1> /dev/null ; then
	echo -ne '[=======              ](28.5%)\r'
else
	echo "mkfs not found...install mkfs and come back later..."
	echo "You could still use dd manually and fill in the following information."
	echo "sudo dd if=output/images/sdcard.img of=/dev/sdX"
	exit
fi
if which tune2fs 1> /dev/null ; then
	echo -ne '[==========           ](42.8%)\r'
else
	echo "tune2fs not found...install tune2fs and come back later..."
	echo "You could still use dd manually and fill in the following information."
	echo "sudo dd if=output/images/sdcard.img of=/dev/sdX"
	exit
fi
if which mkfs.vfat 1> /dev/null ; then
	echo -ne '[============         ](57.1%)\r'
else
	echo "mkfs.vfat not found...install mkfs.vfat and come back later..."
	echo "You could still use dd manually and fill in the following information."
	echo "sudo dd if=output/images/sdcard.img of=/dev/sdX"
	exit
fi
if which lsblk 1> /dev/null ; then
	echo -ne '[===============      ](71.4%)\r'
else
	echo "lsblk not found...install lsblk and come back later..."
	echo "You could still use dd manually and fill in the following information."
	echo "sudo dd if=output/images/sdcard.img of=/dev/sdX"
	exit
fi
if which tar 1> /dev/null ; then
	echo -ne '[==================   ](85.6%)\r'
else
	echo "tar not found...install tar and come back later..."
	echo "You could still use dd manually and fill in the following information."
	echo "sudo dd if=output/images/sdcard.img of=/dev/sdX"
	exit
fi
if which dd 1> /dev/null ; then
	echo -ne '[==================== ](99.9%)\r'
else
	echo "dd not found...install dd and come back later..."
	echo "You could still use dd manually and fill in the following information."
	echo "sudo dd if=output/images/sdcard.img of=/dev/sdX"
	exit
fi
echo -ne '[=====================](100%)\r'
echo -ne '\n'
echo "Prerequisites check finished. If you made it here you're good!"
##################################################
#Detect SD Card...
##################################################
echo "Looking for removable devices under 32GB in size..."
echo "You can change line 82 of this script to find SD cards that are bigger."
#Maximum device size (this helps narrow down results if there are multiple disks connected)
max_device_size="32.00"

#If it's a disk and it's removable print the name and size
row=`lsblk | awk '{ if($3 == "1" && $6 == "disk") print ""$1, $4"" }'`

#Make sure we only have row
num_results=`echo "${row}" | wc -l`

#Make sure the result isn't empty
if [ $((num_results)) -eq 1 ] && [ "${row}" != "/dev/" ] && [ "${row}" != "" ]; then
  #Separate the name and size
  device_name=`echo "$row" | awk '{ print ""$1"" }'`
  device_size=`echo "$row" | awk '{ print ""$2"" }'`
  
  #Size will be in format x.xG so we need to take off the gigs to do comparison
  device_size=`echo "${device_size}" | awk -F'G' '{ print ""$1"" }'`
  
  #Make sure size is less than 32G
  if [ $(echo " ${device_size} < ${max_device_size}" | bc) -eq 1 ]; then
    #Print device name
    echo "Found SD device - ${device_name}"
  else
    #No matching devices
    echo "No devices under 32GB installed..."
    exit 1
  fi

else
  #Too many rows!
  if [ -z "${row}" ]; then
    echo "Results were empty!"
    echo "Doesn't look like you have any removable devices installed."
  fi
  if [ $((num_results)) -ne 1 ]; then
    echo "$((num_results)) results...exiting..."
    echo "You may have more than one removable device installed."
    echo "Check your SD card reader doesn't make two disks (one of which shows as 0B.)"
  fi
  exit 2
fi
##################################################
#Set the mountpoint for the SD card...
##################################################
sd_mount_point=${device_name}
echo "***************************************************************"
echo "I'm going to use '$sd_mount_point'"
echo "Does that sound right?"
echo "I will not be responsible for you nuking your filesystem."
echo "Please read the README file in build_scripts if you are unsure."
echo "***************************************************************"
read -n1 -r -p "Press any non-NUL character to continue...CTRL+C to exit..." key
##################################################
#Choose trunk or dev branch SD image...
##################################################
PS3='Pick an image to burn: '
select opt in Main-Image Release-Image Custom-Image-Dir Clean-Disk Exit; do
	case $opt in
		"Main-Image")
			echo "You chose Main-Image"
			dd if=../buildroot-2023.11/output/images/sdcard.img of=/dev/$sd_mount_point status=progress
			break
			;;
		"Release-Image")
			echo "You chose Release-Image...make sure you extract your release tar.xz"
			read -p "Tell me your release version number in the format x.x.xx: " release_ver
			read -p "Tell me your release date number in the format MM.DD.YYYY: " release_date
			dd if=../release/de10std_$release_ver/de10std_$release_ver\_$release_date\_signed/sdcard.img of=/dev/$sd_mount_point status=progress
			break
			;;
		"Custom-Image-Dir")
			echo "You chose Custom-Image-Dir..."
			read -p "Enter the Directory Where the Image Resides (absolute path): " img_dir
				if [ -d "$img_dir" ] 
					then
				echo "Found directory, cd there now..." 
					else
				echo "Error: Directory $img_dir does not exist."
				exit
				fi
			dd if=$img_dir/sdcard.img of=/dev/$sd_mount_point status=progress
			break
			;;
		"Clean-Disk")
			echo "***************************************************************"
			echo "I'm going to use '$sd_mount_point'"
			echo "Does that sound right?"
			echo "I will not be responsible for you nuking your filesystem."
			echo "Please read the README file in build_scripts if you are unsure."
			echo "***************************************************************"
			read -n1 -r -p "Press any non-NUL character to continue...CTRL+C to exit..." key
			fdisk /dev/$sd_mount_point <<EOF
d
1
d
2
d
3
d

w
EOF
			break
			;;
		"Exit")
			break
			;;
		*) echo "No such option exists... $REPLY";;
	esac
done