#! /bin/bash

DESTDIR="/home/pi/rpi_videoloop/"
INIT="/etc/init.d/"
SCRIPT="videoloop.sh"
CONTROLLER="vid_controller"
USBCONF="usbmount.conf"
USBDIR="/etc/usbmount/"

#Replacing existing installation files if existing
if [ -e "$INIT$CONTROLLER" ]; then
  cp "$INIT$CONTROLLER"
else
  echo "No init.d config found, please use install.sh."
fi
if [ -e "$DESTDIR$SCRIPT" ]; then
  cp "$DESTDIR$SCRIPT"
  chown pi:pi "$DESTDIR$SCRIPT"
else
  echo "No script found, please use install.sh."
fi
if [ -e "$USBDIR$USBCONF" ]; then
	cp "$USBDIR$USBCONF"
else
	echo "No usbmount config found, please use install.sh."
fi