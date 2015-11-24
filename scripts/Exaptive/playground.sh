#!/usr/local/bin/bash

main() {
	echo $@
	echo $1
	echo $2
	#testAssocAaray
	testArguments 
}

testAssocAaray() {
	declare -A array
	array=([a]=1 [b]=2)
	array[c]="a b c"

	for k in "${!array[@]}"
	do
		value="\"${array[$k]}\""
		echo $k
		echo "value: $value"
	done
}

testArguments() {
	FILE="/Users/yuinishizawa/Documents/a b"
	OPTIONS="-l $FILE"
	command="stat -l \"$FILE\""
	eval "$command"
}

main "$@"
