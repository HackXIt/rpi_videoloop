"""
Just testing purposes of short code passages
"""
# Library imports
import subprocess

output = subprocess.check_output('ls -d1 ~/Pictures/*.mp4',
                                 shell=True).decode("utf-8")
print(output.split('\n')[0])