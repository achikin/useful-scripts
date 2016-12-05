#!/bin/bash
#Convert text to speech. You'll need your own api key from voicerss.org
FORMAT=8khz_16bit_mono
CODEC=WAV
LANG=en-us
FILE=""

parse_args() {
  for i in "$@"
  do
  case $i in
      -l=*|--lang=*)
      LANG="${i#*=}"
      shift # past argument=value
      ;;
      -f=*|--file=*)
      FILE="${i#*=}"
      shift # past argument=value
      ;;
  esac
  done
  if [[ -n $@ ]]; then
      TEXT=$@
  fi
}

get_key() {
  API_KEY=""
  if [ -f ~/.voicerss.key ]
  then
    API_KEY=$(cat ~/.voicerss.key)
  else
    API_KEY=$(cat ./.voicerss.key)
  fi
  if [ -z "$API_KEY" ]
  then
    (>&2 echo "API key not found. Please get one from voicerss.org and put it in either ~/.voicerss.key or ./.voicerss.key")
    exit 1
  fi
}

get_filename() {
  FILENAME=$(echo $1 | sed 's/[ \,\.\?\!]/_/g').$(echo "$CODEC" | awk '{print tolower($0)}')
}

download() {
  curl -o $2 -s -G http://api.voicerss.org --data-urlencode "key=$API_KEY" --data-urlencode "src=$1" --data-urlencode "hl=$LANG" --data-urlencode "c=$CODEC" --data-urlencode "f=$FORMAT"
}
###################################################

get_key
parse_args $@

if [ -n "$FILE" ]
then
  while IFS='' read -r line || [[ -n "$line" ]]
  do
    get_filename "$line" 
    download "$line" $FILENAME
  done < "$FILE"
else
  if [ -n "$TEXT" ]
  then
    get_filename "$TEXT" 
    download "$TEXT" $FILENAME
  else
    echo "Usage 1: text_to_speech -f=file_with_prases.txt -l=en-us"
    echo Usage 2: text_to_speech -l=en-us '"Some text to speak"'
    echo Usage 3: text_to_speech '"Some text to speak"'
  fi
fi
