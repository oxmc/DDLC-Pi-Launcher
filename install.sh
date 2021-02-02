#!/bin/bash

# Define variables used in this script
DIRECTORY = "$HOME/DDLC-Pi-Launcher"
# Download dependencies
echo "Downloading dependencies..."
apt-get update
apt-get install -y git python3 python yad renpy
# Aks user if they have a copy of DDLC
yad --no-click --separator='\n' \
	--title='DDLC-Pi-Launcher installer' --center --window-icon="$DIRECTORY/icons/logo.png" \
	--text=" Do you have a copy of DDLC?" \
	--button="No!$HOME/DDLC-Pi-Launcher/icons/exit.png:1" \
	--button="Yes!$HOME/DDLC-Pi-Launcher/icons/check.png:0" \
	--image="$HOME/DDLC-Pi-Launcher/icons/download.png" \
	--no-selection 2>/dev/null
button=$?
if [ ! $button -eq 0 ];then
  echo "User does not have a copy of DDLC."
  yad --no-click --separator='\n' \
	--title='DDLC-Pi-Launcher installer' --center --window-icon="${DIRECTORY}/icons/logo.png" \
	--text=" Do you want me to download a copy of DDLC?" \
	--button="No!${DIRECTORY}/icons/exit.png:1" \
	--button="Yes!${DIRECTORY}/icons/check.png:0" \
	--image="${DIRECTORY}/icons/install.png" \
	--no-selection 2>/dev/null
  DLDDLC="$?"
  if [ $DLDDLC == "y" or $button == "0" ]
    echo "Downloading DDLC..."
    wget https://download1499.mediafire.com/anzlui69h0dg/vrlt8gx2ii4j7k3/ddlc-win.zip || error "Unable to download DDLC!"
    echo "Downloaded DDLC!"
  fi
else
echo "User has a copy of DDLC."
yad --no-click --file="$HOME" --separator='\n' \
	--title='DDLC-Pi-Launcher installer' --center --window-icon="${DIRECTORY}/icons/logo.png" \
	--text=" Please select the folder containing DDLC." \
	--button="No!${DIRECTORY}/icons/exit.png:1" \
	--button="Yes!${DIRECTORY}/icons/check.png:0" \
	--image="${DIRECTORY}/icons/install.png" \
	--no-selection 2>/dev/null
fi
