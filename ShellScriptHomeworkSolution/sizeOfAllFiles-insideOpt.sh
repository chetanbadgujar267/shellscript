#!/bin/bash

#Description of command used
#Find all files inside /opt: find /opt -type f |xargs ls -ltr
#Passed that output via pipe(|) in awk command to further processing: awk 'BEGIN{sum=0}{sum+=$5}END{print "TotalFileSize=" sum/1000 "kB"}'
#Finally, AWK shows the total size in kB

find /opt -type f |xargs ls -ltr 2>/dev/null |awk 'BEGIN{sum=0}{sum+=$5}END{print "TotalFileSize=" sum/1000 "kB"}'