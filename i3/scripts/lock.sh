#!/bin/bash
#define good wallpaper
#res=$(xrandr | grep "eDP1")
#if [ -n $res]; then
	#res=$(xrandr | grep "eDP-1")
	#res=${res:16:9}
#else
	#res=${res:15:9}
#fi
#screenLock=~/.i3/wallpaper/screenLock_$res\.png

#Define static lock screen
screenLock=~/.config/i3/wallpaper/darkLion\.png
i3lock -tei $screenLock
sleep 1;
xset dpms force off
