#!/bin/bash
### Lock screen then suspend
# Lock screen
screenLock=~/.config/i3/wallpaper/darkLion\.png
i3lock -tei $screenLock

# Suspend
systemctl suspend
