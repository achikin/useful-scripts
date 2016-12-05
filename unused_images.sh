#!/bin/sh
#Search for unused images and for @2x images without other versions in xcode projects
PROJ=`find . -name '*.xib' -o -name '*.[mh]' -o -name '*.plist'`

for png in `find . -name '*.png' | grep -v @2x | grep -v ~ipad | grep -v ~iphone`
do
  name=`basename $png`
	if ! grep -q $name $PROJ; then
	  echo "$png is not referenced"
	fi
done

for png in `find . -name '*@2x.png'`
do
  name=${png%@2x.png}
	[ ! -f $name.png ] && echo "$png does not have non-2x version"
done
