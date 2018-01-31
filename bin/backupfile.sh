#!/bin/bash
#
#

FLAG_MESSAGE="m"
FLAG_BACKUPDIR="d"
FLAG_BACKUPNAME="n"
BACKUPNOTESNAME="backup_notes.log"

FILES=()
MESSAGE=""
BACKUP_BASEDIR=""
BACKUP_NAME=""

printUsage() {
	echo "$0 -$FLAG_MESSAGE message -$FLAG_BACKUPNAME name -$FLAG_BACKUPDIR dir path1 [path2 ...]"
}

printLog() {
	echo "backup: $1"
}


#
# Parse options
#
while getopts m:d:n: OPTNAME
do
	case $OPTNAME in
		$FLAG_MESSAGE)
			MESSAGE=$OPTARG
			;;
		$FLAG_BACKUPDIR)
			BACKUP_BASEDIR=$OPTARG
			;;
		$FLAG_BACKUPNAME)
			BACKUP_NAME=$OPTARG
			;;
		\?)
			break
			;;
	esac
done

# Rest
shift $((OPTIND - 1))
FILES=(${*// /})


#
# Validate
#
if [[ ! $BACKUP_NAME ]]
then
	echo "Missing backup name"
	printUsage
	exit 1
fi
printLog "Creating backup '$BACKUP_NAME'"

if [[ ! $BACKUP_BASEDIR || ! -d $BACKUP_BASEDIR ]]
then
	echo "Missing backup dir"
	printUsage
	exit 1
fi

if [[ ! $MESSAGE ]]
then
	echo "Missing backup message"
	printUsage
	exit 1
fi


#
# Start
#
TIMESTAMP=`date '+%Y%m%d_%H%M%S'`
BACKUP_PATH="${BACKUP_BASEDIR}/${BACKUP_NAME}_$TIMESTAMP"
BACKUP_NOTESPATH="${BACKUP_BASEDIR}/${BACKUPNOTESNAME}"

#
# Create backup
#
printLog "Backing up to '$BACKUP_PATH'"
mkdir "$BACKUP_PATH"
for file in ${FILES[@]}
do
	printLog "Copying $file to $BACKUP_PATH"
	cp -r "$file" "$BACKUP_PATH"
	if [[ $? != 0 ]]; then exit 1; fi
done


#
# Backup notes
#
BACKUP_NOTESPATH_TEMP="${BACKUP_NOTESPATH}_tmp"
touch "$BACKUP_NOTESPATH"
echo "$BACKUP_NAME [$TIMESTAMP]" > $BACKUP_NOTESPATH_TEMP
echo "$MESSAGE" >> $BACKUP_NOTESPATH_TEMP
echo "" >> $BACKUP_NOTESPATH_TEMP
cat $BACKUP_NOTESPATH >> $BACKUP_NOTESPATH_TEMP
mv -f $BACKUP_NOTESPATH_TEMP $BACKUP_NOTESPATH
printLog "See ${BACKUP_NOTESPATH} for backup info."
