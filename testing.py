"""
Just testing purposes of short code passages
"""
# Library imports
import subprocess

def check_file():
    output = subprocess.check_output('ls -d1 ~/Pictures/*.mp4',
                                     shell=True).decode("utf-8")
    return output.split('\n')[0]
def play_video(input=None):
    if input is not None:
        play = subprocess.run('omxplayer -o hdmi %s &' % input, shell=True)
        return play

try:
    video = check_file()
except subprocess.CalledProcessError as lsError:
    print('Returncode: ', lsError.returncode)

done = True
while done:
    try:
        done = False
        if type(play_video(video)) is subprocess.CompletedProcess:
            print('Playing video finished')
            done = True
        else:
            print('Hmm.')
    except subprocess.CalledProcessError as playError:
        print('Returncode: ', lsError.returncode)