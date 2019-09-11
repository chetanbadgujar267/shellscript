echo "what arithmatic operation you want do perform?addition,substraction or multiplication"
echo "enter 1 for addition, 2 for substraction and 3 for multiplication"
read operation

echo "enter any two integers"
read int1 int2

if [[ $operation -eq 1 ]];then
result=$((int1+int2))
echo "The sum of $int1 and $int2 is $result"
elif [[ $operation -eq 2 ]];then
result=$((int1-int2))
echo "The substraction of $int1 and $int2 is ${result}"
elif [[ $operation -eq 3 ]];then
result=$((int1*int2))
echo "The multiplication of $int1 and $int2 is $result"
else
echo "intered value is incorrect"
fi