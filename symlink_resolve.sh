#!/bin/bash
#Get the real file path, resolving symlinks
echo $(cd $(dirname $0); pwd -P)/$(basename $0)
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
    DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
      SOURCE="$(readlink "$SOURCE")"
        [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
      done
      DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
      echo $SOURCE
      echo $DIR
