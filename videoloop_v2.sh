#!/bin/bash
# This script plays the videos in the VPATH directory in a loop

# Path of the directory containing the videos
VPATH="/media/"
# Variable für vorhandene videofiles in angesteckten USB-Sticks
ENTRIES=$(find $VPATH | grep -e .avi -e .mov -e .mkv -e .mp4 -e .m4v)
PLAYER="omxplayer"

# Loop through each file in VPATH until stopped

while true; do
#WENN omxplayer in Prozessliste vorhanden -> Nichtstun
if pgrep -f "$PLAYER" > /dev/null
then
sleep 1;
#WENN NICHT dann spiele videos von USB ab
else
for entry in $ENTRIES
do
clear
omxplayer -r "$entry" > /dev/null
done
fi
done