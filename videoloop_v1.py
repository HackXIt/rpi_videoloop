#!/usr/bin/python3.6
"""
This script loops a video found on attached USB Sticks.
Rev1: Currently only grabs the first .mp3 file found (Sorted by name)
Rev2: Restarts loop upon certain exit status (3 = user quit, 1 = failure quit)
"""
# Library imports
import subprocess, sys

# Version Control -> Dependency Python 3.6: subprocess.run()
if sys.version_info >= (3,6):
    print("Version OK")
    version_check_ok = True
else:
    print("Missing Dependencies: Python3.6")
    version_check_ok = False

def check_file():
    output = subprocess.check_output('find /media/ | grep .mp4',
                                     shell=True).decode("utf-8")
    return output.split('\n')
def play_video(input=None):
    if input is not None:
        play = subprocess.run('omxplayer %s --aspect-mode fill --vol 0 -o hdmi --no-osd' % input, shell=True)
        return play

try:
    if version_check_ok:
        video = check_file()
except subprocess.CalledProcessError as error:
    print('Returncode: ', error.returncode)
if version_check_ok:
    user_exit = False
else:
    user_exit = True
	
print(video)
# Infinite Loop for the video, condition triggers when either program fails or user exits by input.
# Video already loops via omxplayer, this is a failsafe
while not user_exit:
	for file in video:
		if file is not '':
			check = play_video(file)
			if check is not 0:
				user_exit = True
    
# Exit Code != 0 --> DEBUG: WHY?
print(check)
