read -p "Enter the tower height: " towerHeight
for ((i=1;i<=towerHeight;i++))
do
rightAdjust=$((towerHeight-i))
printf '%*s' $rightAdjust
for ((j=1;j<=i;j++))
do
printf "* "
done
echo -e "\n"
done
