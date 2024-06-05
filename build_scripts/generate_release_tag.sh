#!/bin/bash
#
#Generate GitHub release tag
#ejc-01.07.2024
#Last updated: 01.07.2024
#
##################################################
#Variables
##################################################
version=$(grep Version ../buildroot-2023.11/board/terasic/de10-std/overlay/etc/motd | sed 's/^.*[^0-9]\([0-9]*\.[0-9]*\.[0-9]*\).*$/\1/')
echo ""
echo "*******************************************************"
echo "Don't run this until all sources are committed to main!"
echo "Are you sure you want to generate release tag?"
echo "*******************************************************"
echo "You will also need your GitHub personal access token!"
echo "*******************************************************"
read -n1 -r -p "Press any non-NUL character to continue...CTRL+C to exit..." key
##################################################
#Generate release tag...
##################################################
git tag -s v$version -m "de10std_$version"
git tag --verify v$version
git push --tags origin
echo "Done!"