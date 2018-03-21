#!/bin/bash

#Variables
DEPENDENCIES="omxplayer screen cron usbmount"
SCRIPT="videoloop_v2.sh"
CONTROLLER="vid_controller"
USBCONF="usbmount.conf"
CRONSTUFF=$(cat cron.txt)

# Checking | Installing Dependancies
if apt list $DEPENDENCIES | grep installed > /dev/null
then
echo "$DEPENDENCIES already installed. Continuing."
else
apt-get update
apt-get install $DEPENDENCIES -y
fi

echo "Installing Configurations..."

#Configuring
mkdir /home/pi/rpi_videoloop
cp $SCRIPT /home/pi/rpi_videoloop/
sudo cp $CONTROLLER /etc/init.d/
cp $USBCONF /etc/usbmount/
sudo chmod 755 /home/pi/rpi_videoloop/$SCRIPT
sudo chmod 755 /etc/init.d/$CONTROLLER
sudo update-rc.d vid_controller defaults
sudo echo -n " consoleblank=10" >> /boot/cmdline.txt
#cat alias.txt >> ~/.bashrc
#sudo cat alias.txt >> ~/.bashrc
(crontab -u pi -l; echo "$CRONSTUFF" ) | crontab -u pi -

echo "FINISHED INSTALLATION: Service control -> /etc/init.d/vid_controller {start|stop|check|repair}"
