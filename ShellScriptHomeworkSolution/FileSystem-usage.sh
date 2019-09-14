#!/bin/bash

#Find all the File System which usage is more than 10%
echo "FileSyatem\tUsage"
df -Ph|tail -n +2|while read LINE
do
diskUsage=`echo $LINE|awk '{print $5}'|awk -F% '{print $1}'`
if [ $diskUsage -gt 10 ];then
echo $LINE|awk '{print $1"\t"$5}'
fi
done