#!/usr/bin/python3
"""
This script loops a video found on attached USB Sticks.
Rev1: Currently only grabs the first .mp3 file found (Sorted by name)
Rev2: Restarts loop upon certain exit status (3 = user quit, 1 = failure quit)
"""
# Library imports
import subprocess

def check_file():
    output = subprocess.check_output('find /media/ | grep .mp4',
                                     shell=True).decode("utf-8")
    return output.split('\n')[0]
def play_video(input=None):
    if input is not None:
        play = subprocess.call('omxplayer --aspect-mode fill --vol 0 --loop -o hdmi %s --no-osd' % input, shell=True)
        return play

try:
    video = check_file()
except subprocess.CalledProcessError as error:
    print('Returncode: ', error.returncode)

check = 3
# Infinite Loop for the video, condition triggers when either program fails or user exits by input.
# Video already loops via omxplayer, this is a failsafe
while check is not 0:
    check = play_video(video)
    if check is 3:
        user_exit = True
    
# Exit Code = 0
print(check)
