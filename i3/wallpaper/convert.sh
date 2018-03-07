#!/bin/bash
#script wich convert a .jpg file in .png with a specified size
convert -resize 1920x1200 $1.jpg $1.png
