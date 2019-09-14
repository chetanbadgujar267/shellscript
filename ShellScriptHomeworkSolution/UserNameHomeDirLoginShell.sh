#!/bin/bash

#Show userName, homeDirectory and loginShell of system users

cat /etc/passwd|awk -F: 'BEGIN{print "UserName\t\tHomeDirectory\t\tLoginShell"}{print $1 "\t\t\t" $6 "\t\t\t" $7}'