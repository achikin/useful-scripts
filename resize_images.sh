#!/bin/bash
#usage resize_images.sh 52x67 - create 52x67 thumbnails for all jpg images in current folder
for file in $(ls *.jpg);do convert -resize $1\! $file ${file#.jpg}$1.jpg;done
