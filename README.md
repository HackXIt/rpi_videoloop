# rpi_videoloop
Simple Python(v1)/Shell(v2) script for the raspberry pi that uses the omxplayer to loop .mp4 files found on various attached USB-Sticks

The shell scripting is adapted / derived from [this guide!](https://community.spiceworks.com/how_to/148722-loop-multiple-videos-on-a-raspberry-pi)

It only reads .mp4 files but this can be adapted since omxplayer should be capable of other files as well.

The install script attempts to install omxplayer, screen, usbmount and cron if not already installed.

It modifies the following:
* /etc/usbmount/usbmount.conf (will be replaced)
* /boot/cmdline.txt ("consoleblank=10" will be appended)
* /etc/init.d/vid_controller (will be added)
* crontab of user pi will be edited with 2 lines

Installation:
1. Clone into the repository
2. sudo bash install.sh
3. Wait for installation to finish
4. Reboot (optional but recommended)
5. Try starting the service via "/etc/init.d/vid_controller start"
6. USB-Sticks should be automatically detected and mounted, doesn't matter where the files on the sticks are places as long as they have the .mp4 ending

-----

For the Python script 3.6 is required. It's a very rough code and there's not really much I can say other than I don't recommend it as of yet, it's simply my attempt at doing this with python and I've abandoned it.
