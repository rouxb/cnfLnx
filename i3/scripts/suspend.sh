#!/bin/bash
### Lock screen then suspend
# Lock screen
screenLock=~/.config/i3/wallpaper/wall3\.png
i3lock -tei $screenLock

# Suspend
systemctl suspend
