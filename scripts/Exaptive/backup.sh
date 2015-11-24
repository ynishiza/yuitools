#!/bin/bash
TARGET="$HOME/Dropbox (Personal)/Backups/work"
#TARGET2="$HOME/Google Drive/Backups/work"
DIRS=()
DIRS[0]="$HOME/Sites"
DIRS[1]="$HOME/Documents"
DIRS[2]="$HOME/Dropbox (Personal)/Permanent/Computers/Tools"

OPTIONS="-r -u -h --progress"
# Don't follow symbolic links.
OPTIONS="$OPTIONS --safe-links"
# max size
OPTIONS="$OPTIONS --max-size=20M"
OPTIONS="$OPTIONS --filter='- .git/' --filter='- node_modules/'"
OPTIONS="$OPTIONS --filter='- .cabal-sandbox/'"
OPTIONS="$OPTIONS --filter='- *.swp'"

echo "Backing up to $TARGET."
for dir in "${DIRS[@]}"
do
	echo "Backing up $dir"
	#rsync --exclude=".git" -r -u -h --progress "$dir" "$TARGET"

	COMMAND="rsync $OPTIONS \"$dir\" \"$TARGET\""
	eval $COMMAND
done

# Don't store node modules.
#find "$TARGET" -name "node_modules" -type d -exec rm -rf {} \;

# Delete swaps
find "$TARGET" -iname "*.swp" -delete
