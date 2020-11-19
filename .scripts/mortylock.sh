#!/bin/bash
TMPBG=/tmp/screen.png
LOCK=$HOME/Img/lock.png
RES=2560x1440

ffmpeg -f x11grab -video_size $RES -y -i $DISPLAY -i $LOCK -filter_complex "boxblur=15:10,overlay=(main_w-overlay_w)/2:(main_h-overlay_h)/2" -frames:v 1 $TMPBG


i3lock -u -e -i $TMPBG