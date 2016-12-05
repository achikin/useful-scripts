#!/bin/bash
# Download torrents using aria2c with some useful automations
if [ -z "$(which aria2c)" ]
then
  echo "This script expects aria2c to be installed"
  echo "Try brew install aria"
  exit 1
fi
if [ -z "$1" ]
then
  echo "Usage:" 
  echo "Downlad all files:"
  echo '  download_torrents.sh [torrent_name]'
  echo ''
  echo "Download only files that match pattern:"
  echo '  download_torrents.sh [torrent_name] [grep_string]'
  echo ''
  echo 'Example: download only first episode of series'
  echo '  download_torrents.sh XFiles.torrent s01'
  exit 1
fi
if [ -z "$2" ]
then
  aria2c $1
  exit 0
fi
grep_result=$(aria2c --show-files $1 | egrep '\d+\|' | grep $2)
if [ -z "$grep_result" ]
then
  echo Did not find any files in $1 that match $2
  exit 1
fi
files=$(echo "$grep_result" | awk -F'|' '{gsub(" ", "", $1)};{printf "%s,", $1};')
echo $files
aria2c --select-file $files $1
