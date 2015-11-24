#!/usr/local/bin/bash
#
#
#
SCRIPTNAME=$0
TIMESTAMP=`date '+%m/%d/%Y_%H%:%M:%S'`

PrintUsage() {
	echo "$SCRIPTNAME"
}

#
# Options
#
while getopts "ab:" OPTNAME
do
	case $OPTNAME in
		a)
			HAS_A=1
			#
			;;
		b) 
			#
			BVALUE=$OPTARG
			;;
		\?)
			# 
			#
			#
			break
			;;
	esac
done

#
#
#
shift $((OPTIND - 1))

if [[ ! ($BVALUE && $HAS_A) ]]; then echo "Too few arguments"; PrintUsage; exit 1; fi

#
#
#
echo "Done"
