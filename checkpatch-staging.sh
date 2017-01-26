#!/bin/bash

TOP_SRC_TREE="/home/chenwx/linux"
STAGING_DIR="$TOP_SRC_TREE/drivers/staging"
SCRIPT_DIR="$TOP_SRC_TREE/scripts"
RESOULT_DIR="$TOP_SRC_TREE/checkpatch-staging"

if [ -d "$RESOULT_DIR" ]; then
	`rm -rf $RESOULT_DIR`
fi

`mkdir $RESOULT_DIR`

DIRS=`find $STAGING_DIR -maxdepth 1 -type d`
for dir in $DIRS
do
	lastdir=${dir##*/}
	if [ "$lastdir" == "staging" ]; then
		echo "Don't care of files in top directory $dir!"
	else
		echo "Checking $dir > $RESOULT_DIR/$lastdir.log"
		`find $dir -type f -name "*.[hc]" | xargs $SCRIPT_DIR/checkpatch.pl -terse -f > $RESOULT_DIR/$lastdir.log`
	fi
	echo
done

