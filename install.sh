#!/bin/bash

set -eu

if ! test $UID -eq 0
then
	test -t 0 && exec sudo "$0" "$@"
  # Not a terminal - or exec failed
  echo "Insufficient privileges - try sudo $0 $*" >&2
  exit 1
fi

DEPENDENCIES=("omxplayer" "screen" "cron" "usbmount" "ntfs-3g")

#Variables
DESTDIR="/home/pi/rpi_videoloop/"
INIT="/etc/init.d/"
SCRIPT="videoloop.sh"
CONTROLLER="vid_controller"
USBCONF="usbmount.conf"
USBDIR="/etc/usbmount/"
CRONTEXT=$(< cron.txt)

# Checking | Installing Dependancies
echo "Installing dependencies."
if [ "$#" ]; then
	apt-get install "${DEPENDENCIES[@]}" -y
else
  apt-get install "${DEPENDENCIES[@]}" "$1" # Will exit immidiatly if failed due to Line 2^
  exit 1  # Not supporting parameters for now
fi

echo "Installing Configurations..."

#Configuring
if [ ! -d "$DESTDIR" ]; then 
  install --group=pi --owner=pi -d "$DESTDIR"
  echo "Directory created..."
fi
install --group=pi --owner=pi -t "$DESTDIR" "$SCRIPT"
if [ ! -f "$INIT$CONTROLLER" ]; then
  install --group=pi --owner=pi -t "$INIT" "$CONTROLLER"
  echo "Init script installed..."
fi
if [ ! -f "$USBDIR$USBCONF" ]; then
  install --group=pi --owner=pi -t "$USBDIR" "$USBCONF"
  echo "Usbmount configuration installed..."
fi
update-rc.d "$CONTROLLER" defaults
echo "Init.d updated..."
if ! "cat /boot/cmdline.txt | grep consoleblank= >> /dev/null"; then
  printf " consoleblank=10" | sudo tee -a /boot/cmdline.txt
  echo "cmdline.txt updated..."
fi
#printf "\n%s\n" "$(< alias.txt)" >> /home/pi/.bashrc
#printf "\n%s\n" "$(< alias.txt)" >> /root/.bashrc
#(crontab -u pi -l; echo "$CRONTEXT" ) | crontab -u pi -
#crontab -l | { cat; echo "$CRONTEXT"; } | crontab -
#Execute crontab twice to avoid "No crontab for user" message + sort | uniq to avoid creating duplicates
( (crontab -l 2>/dev/null || echo "") ; echo "$CRONTEXT") | sort -u - | crontab -
echo "Crontab installed"
if [ ! -f "/bin/videoloop" ]; then
  ln -s "$INIT$CONTROLLER" -T /bin/videoloop
  echo "Symbolic link / shortcut created..."
fi

echo "FINISHED INSTALLATION: Service control -> /etc/init.d/vid_controller {start|stop|check|repair}"
echo "or execute in terminal: videoloop {start|stop|check|repair}"