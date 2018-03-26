#!/bin/bash

#Variables
DEPENDENCIES="omxplayer screen cron usbmount"
PATH="/home/pi/rpi_videoloop"
INIT="/etc/init.d"
SCRIPT="videoloop_v2.sh"
CONTROLLER="vid_controller"
USBCONF="usbmount.conf"
CRONSTUFF=$(cat cron.txt)

# Checking | Installing Dependancies
if ! [ apt list $DEPENDENCIES | grep -v installed | grep -E 'omxplayer|screen|cron|usbmount' > /dev/null ]
then
echo "Dependencies already installed. Continuing."
else
apt-get update
apt-get install $DEPENDENCIES -y
fi

echo "Installing Configurations..."

#Configuring
if [ ! -d "$PATH" ]; then 
    mkdir $PATH
fi
cp $SCRIPT $PATH
if [ ! -f $INIT/$CONTROLLER ]; then
    sudo cp $CONTROLLER $INIT
fi
cp $USBCONF /etc/usbmount/
sudo chmod 755 $PATH/$SCRIPT
sudo chmod 755 $INIT/$CONTROLLER
sudo update-rc.d $CONTROLLER defaults
sudo echo -n " consoleblank=10" >> /boot/cmdline.txt
#cat alias.txt >> ~/.bashrc
#sudo cat alias.txt >> ~/.bashrc
(crontab -u pi -l; echo "$CRONSTUFF" ) | crontab -u pi -

echo "FINISHED INSTALLATION: Service control -> /etc/init.d/vid_controller {start|stop|check|repair}"
