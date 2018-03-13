"""
Just testing purposes of short code passages
"""
# Library imports
import subprocess

def check_file():
    output = subprocess.check_output('find /media/ | grep .mp4',
                                     shell=True).decode("utf-8")
    return output.split('\n')[0]
def play_video(input=None):
    if input is not None:
        play = subprocess.call('omxplayer --aspect-mode fill --vol 0 --loop -o hdmi %s' % input, shell=True)
        return play

try:
    video = check_file()
except subprocess.CalledProcessError as error:
    print('Returncode: ', error.returncode)

#done = True
#count = 0

check = play_video(video)
print(check)

"""
while done:
    try:
        done = False
        if type(play_video(video)) is subprocess.CompletedProcess:
            print('Playing video finished')
            done = True
            count += 1
        else:
            print('Hmm.')
        if count > 5:
            break
    except subprocess.CalledProcessError as playError:
        print('Returncode: ', lsError.returncode)
"""
