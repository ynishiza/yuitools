#!/bin/bash
delim="/"

#
# Input
#
searchdir=$1
search=$2
replace=$3

# Validate
if [[ ! -d $searchdir ]]; then echo "Invalid search directory $searchdir"; exit 1 ; fi
if [[ ! $search ]]; then echo "Missing search term"; exit 1; fi
if [[ ! $replace ]]; then echo "Missing replace  term"; exit 1; fi


#
# Main
#
srcfiles=$(eval "find \"$searchdir\" -type f | sed -n -e '/$search/p'")
srcfiles=(${srcfiles// /})
destfiles=$(eval "find \"$searchdir\" -type f | sed -n -e 's/$search/$replace/p'")
destfiles=(${destfiles// /})

if [[ ${#srcfiles} == 0 ]]; then echo "No files found."; exit 1; fi

# Step 1) Confirm
for i in ${!srcfiles[@]}
do
	echo "${srcfiles[$i]}-> ${destfiles[$i]}"
done
echo "Rename? (y/n)"
read check
if [[ $check != "y" ]]; then echo "Stop"; exit 1; fi

# Step 2) Perform
for i in ${!srcfiles[@]}
do
	mv "${srcfiles[$i]}" "${destfiles[$i]}"
done
