#bin\sh
FOLDER=`basename -a "$PWD"`
M3U_NAME=00\ $FOLDER.m3u
touch "$M3U_NAME"
echo "`ls -1 -a *.flac`" >> "$M3U_NAME"
echo "m3u generated"
exit