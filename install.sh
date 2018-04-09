#!/bin/bash
set -eu

if ! test $UID -eq 0
then
   test -t 0 && exec sudo "$0" "$@"
   # Not a terminal - or exec failed
   echo "Insufficient privileges - try sudo $0 $*" >&2
   exit 1
fi

#Variables
DEPENDENCIES="omxplayer screen cron usbmount ntfs-3g"
DEPENDENCIES=("${DEPENDENCIES[@]}")
DESTDIR="/home/pi/rpi_videoloop/"
INIT="/etc/init.d/"
SCRIPT="videoloop_v2.sh"
CONTROLLER="vid_controller"
USBCONF="usbmount.conf"
USBDIR="/etc/usbmount/"
CRONTEXT=$(< cron.txt)

# Checking | Installing Dependancies
if ! apt list "${DEPENDENCIES[*]}" | grep -v installed | grep -E "${DEPENDENCIES[@]// /|}" > /dev/null
then
echo "Dependencies already installed. Continuing."
else
echo "Installing dependencies."
apt-get update
apt-get install "${DEPENDENCIES[*]}" -y
fi

echo "Installing Configurations..."

#Configuring
if [ ! -d "$DESTDIR" ]; then 
    install -d "$DESTDIR"
fi
install -t "$DESTDIR" "$SCRIPT"
if [ ! -f "$INIT$CONTROLLER" ]; then
    install -t "$INIT" "$CONTROLLER"
fi
install -t "$USBDIR" "$USBCONF"
update-rc.d "$CONTROLLER" defaults
printf " consoleblank=10" | sudo tee -a /boot/cmdline.txt
#cat alias.txt >> ~/.bashrc
#sudo cat alias.txt >> ~/.bashrc
(crontab -u pi -l; echo "$CRONTEXT" ) | crontab -u pi -

echo "FINISHED INSTALLATION: Service control -> /etc/init.d/vid_controller {start|stop|check|repair}"