#! /bin/bash

PTH="/home/pi/rpi_videoloop"
INIT="/etc/init.d"
SCRIPT="videoloop_v2.sh"
CONTROLLER="vid_controller"
USBCONF="usbmount.conf"

git pull origin master

#Removing existing installation
if [ -f $INIT/$CONTROLLER ] ; then
    cp $CONTROLLER $INIT/
else
    echo "No init.d config found."
fi
if [ -f $PTH/$SCRIPT ] ; then
    cp $SCRIPT $PTH
else
    echo "No script found."
fi
if [ -f /etc/usbmount/$USBCONF ] ; then
    cp $USBCONF /etc/usbmount
else
    echo "No usbmount config found."
fi
