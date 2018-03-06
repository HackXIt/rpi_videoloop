"""
This python program is meant to loop a video from an
external flash drive with plug&play functionality.
The video can either be directly  played if an mp4 file
is available or be created from one or more images.
"""

import subprocess

output = subprocess.check_output('ls -d1Q ~/media/usbstick/*.mp4', shell=True).decode("utf-8")

print('String: %s \n' % type(output), output)