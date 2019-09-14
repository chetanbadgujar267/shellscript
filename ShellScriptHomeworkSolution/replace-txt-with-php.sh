#!/bin/bash
#Find all .txt files inside /tmp and process one-by-one using while loop

find /tmp -type f -iname "*.txt" | while read FILE
do mv $FILE ${FILE/.txt/.php} #Sub-string substitution (.txt is replaced with .php)
done