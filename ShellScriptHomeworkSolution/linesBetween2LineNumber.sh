#!/bin/bash

echo "\nEnter any two non-zero numbers:"
read num1 num2

#Nested if/else condition
#Outer if/else block is to find both numbers must be non-zero
#Iner if/else block is to find which is big number to identify startLine and endLine

if [ $num1 -ne 0 -a $num2 -ne 0 ];then
  if [ $num1 -lt $num2 ];then
  startLine=$num1
  endLine=$num2
  elif [ $num2 -lt $num1 ];then
  startLine=$num2
  endLine=$num1
  else
  echo "Both numbers are same. Try any two different non-zero numbers.\n"
  exit
  fi
else
echo "Try any two different non-zero numbers.\n"
exit
fi

echo "\nAll lines between line:$startLine and line:$endLine of /etc/passwd:\n"
#Printing lines of /etc/passwd between two given line numbers
sed -n "$startLine,$endLine p" /etc/passwd
echo "\nThanks for using script!\n"