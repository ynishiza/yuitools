#!/bin/bash
for i in {1..10}
do
		echo "Hello$i"
done

for (( i=0; i<10; i++ ))
do
		echo "Bye$i"
done

array=()
array[0]="Zero zero"
array=("${array[@]}" "One one")

echo ${#array[@]}
echo ${array[@]}
echo ${array[*]}
echo $array

for e in ${array[@]}
do
		echo $e
done

if 1
then
		echo Hi
elif 1
then
		echo Hello
else
		echo Bye
fi
