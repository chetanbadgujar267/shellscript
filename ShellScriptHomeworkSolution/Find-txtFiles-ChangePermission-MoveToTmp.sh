#!/bin/bash

#Find all .txt files inside /var/tmp and
#Change its permission to 666 and
#Move it to /tmp

find /var/tmp/ -type f -iname "*.txt"|while read FILE #Find *.txt and apply while loop to process each of them
do chmod 666 $FILE
onlyFileName=`basename $FILE` #taking file name only out of full path of file
mv $FILE /tmp/$onlyFileName   #moving file from /var/tmp to /tmp
done