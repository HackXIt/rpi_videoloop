#! /bin/bash

DESTDIR="/home/pi/rpi_videoloop"
INIT="/etc/init.d"
SCRIPT="videoloop.sh"
CONTROLLER="vid_controller"
USBCONF="usbmount.conf"
USBDIR="/etc/usbmount"

#Replacing existing installation files if existing
if [ -e "$INIT/$CONTROLLER" ]; then
  cp "$CONTROLLER" "$INIT"
  echo "Init.d Controller updated..."
else
  echo "No init.d config found, please use install.sh."
fi
if [ -e "$DESTDIR/$SCRIPT" ]; then
  cp "$SCRIPT" "$DESTDIR"
  chown pi:pi "$DESTDIR/$SCRIPT"
  echo "Script updated..."
else
  echo "No script found, please use install.sh."
fi
if [ -e "$USBDIR/$USBCONF" ]; then
	cp "$USBCONF" "$USBDIR"
  echo "Usbmount updated..."
else
	echo "No usbmount config found, please use install.sh."
fi