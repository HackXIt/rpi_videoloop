"""
Just testing purposes of short code passages
"""
# Library imports
import subprocess

def check_file():
    output = subprocess.check_output('ls -d1 ~/Pictures/*.mp4',
                                     shell=True).decode("utf-8")
    return output.split('\n')[0]

try:
    video = check_file()
except subprocess.CalledProcessError as lserror:
    print('Returncode: ', lserror.returncode)

