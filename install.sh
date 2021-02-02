#!/bin/bash

# Define variables used in this script
DIRECTORY = "$(dirname $0)/DDLC-Pi-Launcher"
# Download dependencies
echo "Downloading dependencies..."
apt-get update
apt-get install -y git python3 python yad renpy
# Aks user if they have a copy of DDLC
#If yad exists, use a yad dialog
if [ -f /usr/bin/yad ];then
  yad --no-click --separator='\n' \
	--title='DDLC-Pi-Launcher installer' --center --window-icon="$DIRECTORY/icons/logo.png" \
	--text=" Do you have a copy of DDLC?" \
	--button="No!$DIRECTORY/icons/exit.png:1" \
	--button="Yes!$DIRECTORY/icons/check.png:0" \
	--image="$DIRECTORY/icons/install.png" \
	--no-selection 2>/dev/null
  button=$?
else #if yad does not exist then fallback to zenity
  zenity --title='DDLC-Pi-Launcher installer' --window-icon="$DIRECTORY/icons/logo.png" \
  	--text=" Do you have a copy of DDLC?" \
  	--ok-label=Yes! --cancel-label=No \
  	--hide-header 2>/dev/null
  button=$?
fi
if [ ! $button -eq 0 ];then
  echo "User does not have a copy of DDLC."
  if [ -f /usr/bin/yad ];then
    yad --no-click --separator='\n' \
	--title='DDLC-Pi-Launcher installer' --center --window-icon="${DIRECTORY}/icons/logo.png" \
	--text=" Do you want me to download a copy of DDLC?" \
	--button="No!${DIRECTORY}/icons/exit.png:1" \
	--button="Yes!${DIRECTORY}/icons/check.png:0" \
	--image="${DIRECTORY}/icons/install.png" \
	--no-selection 2>/dev/null
  else #if yad does not exist
    echo "Do you want me to download a copy of DDLC?"
    read DLDDLC
  fi
    echo "Please type the path to the DDLC folder."
    read DDLCFOLDER

    
else
  echo "User has a copy of DDLC."
fi
