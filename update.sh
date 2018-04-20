#! /bin/bash

PTH="/home/pi/rpi_videoloop/"
INIT="/etc/init.d/"
SCRIPT="videoloop.sh"
CONTROLLER="vid_controller"
USBCONF="usbmount.conf"
USBDIR="/etc/usbmount/"

git pull origin master

#Replacing existing installation files if existing
if [ -e "$INIT$CONTROLLER" ]; then
  cp "$CONTROLLER $INIT"
else
  echo "No init.d config found, please use install.sh."
fi
if [ -e "$PTH$SCRIPT" ]; then
  cp "$SCRIPT $PTH"
else
  echo "No script found, please use install.sh."
fi
if [ -e "$USBDIR$USBCONF" ]; then
	cp "$USBCONF $USBDIR"
else
	echo "No usbmount config found, please use install.sh."
fi