# rpi_videoloop
Simple Shell script for the raspberry pi that uses the omxplayer to loop .mp4 files found on various attached USB-Sticks

The shell scripting is adapted / derived from [this guide!](https://community.spiceworks.com/how_to/148722-loop-multiple-videos-on-a-raspberry-pi)

-----

It only reads files from USB which are supported formats by the omxplayer (.avi, .mov, .mkv, .mp4, .m4v)

The install script attempts to install the following packages if not already installed: 
* omxplayer
* screen
* usbmount
* cron
* ntfs-3g

Another requirement is Raspbian Jessie. On the latest raspbian stretch or in stretch in general the usbmount package doesn't work as intended anymore, therefor raspbian jessie is required for this script to work, at least until I've found a decent alternative.

-----

Installation:
1. Clone into the repository
2. sudo bash install.sh
3. Wait for installation to finish
4. Reboot (optional but recommended)
5. Try starting the service via "/etc/init.d/vid_controller start"
6. USB-Sticks should be automatically detected and mounted, doesn't matter where the files on the sticks are placed as long as they have the proper extension.

To loop through the given files in a specific order rename the files by adding a number to the front, which will be the order in which they are played.
For example:
- 1_video1.mp4
- 2_video2.avi
- 3_video3.mov
- 4_video4.mkv
- 5_video5.m4v
