#Transcode all mp3 files in this folder to 8000khz pcm_16
#sh -c trick is necessary for basename to work properly
ls *.mp3 | xargs -I NAME sh -c 'ffmpeg -i NAME -ar 8000 -ac 1 $(basename "NAME" ".mp3").wav'
mkdir -p wav
mv *.wav wav/
