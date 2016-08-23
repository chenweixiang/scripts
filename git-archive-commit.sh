#!/bin/bash

#-------------------------------------------------------------------------------
# This Bash script is used to zip a specified commit in current repository.
# The commit is specified by input parameter $1. Use HEAD as the commit if
# no input parameter $1 is specified.
#
# Usage: git-archive-commit.sh [commit-id]
#-------------------------------------------------------------------------------

#
# 1) Get the commit-id
#

if [ "$1" == "" ]; then
    cmt="HEAD"
else
    cmt=$1
fi

#
# 2) Get the name of current repository
#

reporoot=`git rev-parse --show-toplevel`
reponame=`basename ${reporoot}`

#
# 3) Archive the specified commit 'shortcmt' to 'filename'
#

shortcmt=`git rev-parse --short ${cmt}`
filename=${reponame}-commit-${shortcmt}.zip
git archive -o ${filename} ${shortcmt}

echo Archive repository commit ${shortcmt} to ${filename}


