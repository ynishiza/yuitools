#!/bin/bash
TARGET="$HOME/Dropbox (Personal)/Backups/work"
#TARGET2="$HOME/Google Drive/Backups/work"
DIRS=()
DIRS[0]="$HOME/Sites"
# DIRS[1]="$HOME/Documents"
DIRS[2]="$HOME/Dropbox (Personal)/Permanent/Computers/Tools"
DIRS[3]="$HOME/Projects/exaptive/platform/vagrant/exaptive_stack"

OPTIONS="-r -u -h --progress"
# Don't follow symbolic links.
OPTIONS="$OPTIONS --safe-links"
# max size
#OPTIONS="$OPTIONS --quiet"
OPTIONS="$OPTIONS --max-size=20M"

# Node.js
OPTIONS="$OPTIONS --filter='- .git/'"
OPTIONS="$OPTIONS --filter='- node_modules/'"
# Haskell caches
OPTIONS="$OPTIONS --filter='- .cabal-sandbox/'"
# Python caches
OPTIONS="$OPTIONS --filter='- *.pyc'"
OPTIONS="$OPTIONS --filter='- __pycache__'"
OPTIONS="$OPTIONS --filter='- .tox/'"
# Vim swap
OPTIONS="$OPTIONS --filter='- *.swp'"
OPTIONS="$OPTIONS --delete"


# Log
LOGFILE="${TARGET}/backup.log"
INFOFILE="${TARGET}/backupinfo.txt"
echo "" > "$LOGFILE"
echo "Last backup at $(date)" > "$INFOFILE"
echo "Dest: ${TARGET}" >> "$INFOFILE"
echo $'\nSources:' >> "$INFOFILE"

echo "Backing up to $TARGET."
for dir in "${DIRS[@]}"
do
	echo "Backing up $dir"
	echo "$dir" >> "$INFOFILE"
	#rsync --exclude=".git" -r -u -h --progress "$dir" "$TARGET"

	COMMAND="rsync $OPTIONS \"$dir\" \"$TARGET\" 2>&1 | tee \"$LOGFILE\""
	eval $COMMAND
done

# Don't store node modules.
#find "$TARGET" -name "node_modules" -type d -exec rm -rf {} \;

# Delete swaps
#find "$TARGET" -iname "*.swp" -delete
find "$TARGET" -iregex ".*/\.[a-zA-Z0-9_ \.]*s[uvw].$" -delete
