#!/bin/bash

find /opt |xargs ls -ltr |awk 'BEGIN{print "FileName\tOwnerName"}{print $3"\t"$9}'