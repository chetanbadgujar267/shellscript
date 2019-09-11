echo "enter animal or bird"
read mimicType
if [[ $mimicType = "animal" ]];then
echo "Which animal you want me tyo mimic"
read animalName
animalName=`echo $animalName|tr '[:upper:]' '[:lower:]'`
if [[ $animalName = "dog" ]];then
echo "bhaw bhaw"
elif [[ $animalName = "cat" ]];then
echo "mua mua"
else
echo "This animal is difficult to mmimic"
fi
else
echo "We cant mimic bird"
fi
