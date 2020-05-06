## This software is to find out all free time slots for the given margin time.
## Those free slots would be used to schedule Super VIP Buses.
## This is developed by Prince Gupta on May 05, 2020.

#!/bin/bash

if [ ! -e inputFile ];then
echo -e "\ninputFile is missing."
echo -e "First create inputFile and then run this Software.\n"
exit
fi

echo -e "\n" 
read -p "Enter the margin time: " marginTime

if [ ! -z $marginTime ] && [ $marginTime -gt 0 ];then
count=0
echo -e "\nAvailable time slots:"
while read LINE 
do
occupancy=`echo $LINE|awk '{print $3}'`
if [ $occupancy -eq 0 ]; then
count=$((count+1))
lineNumber=`echo $LINE|awk '{print $1}'`
else
if [ $count -ge $marginTime ];then
startLine=$((lineNumber-count+1))
endLine=$((lineNumber))
startTime=`sed -n "$startLine"p inputFile | awk '{print $2}'`
endTime=`sed -n "$endLine"p inputFile | awk '{print $2}'`
echo "$startTime - $endTime"
fi
count=0
fi
done < inputFile
echo -e "\n"
else
echo -e "\nYou must need to enter margin time and it should be greater than 0."
echo -e "Try Again.\n"
fi
