#!/bin/bash

#-------------------------------------------------------------------------------
# This Bash script is used to zip a specified commit in current repository.
# The commit is specified by input parameter $1. Use HEAD as the commit if
# no input parameter $1 is specified.
#-------------------------------------------------------------------------------

#
# 1) Get the commit-id and output-dir
#

# set default commit-id and output-dir
cmt="HEAD"
outdir="."
path="."

usage="git-archive.sh { [-c commit-id] [-p path ] [-o output-dir] | [-h] }"

# get commit-id and output-dir from input parameters
while getopts "c:p:o:h" arg
do
    case $arg in
        c)  # -c <commit-id>
            cmt=$OPTARG
            ;;
        p)  # -p <path>
            path=$OPTARG
            ;;
        o)  # -o <output-dir>
            outdir=$OPTARG
            ;;
        h)  # help
            echo ${usage}
            exit 1
            ;;
        ?)  # unkonw argument
            echo "unkonw argument"
            exit 1
            ;;
    esac
done

#
# 2) Archive the specified commit 'shortcmt' to 'filename'
#

shortcmt=`git rev-parse --short ${cmt}`

reporoot=`git rev-parse --show-toplevel`
reponame=`basename ${reporoot}`

pathbase=`basename ${path}`
if [ ${pathbase} == "." ]; then
    pathbase=""
else
    pathbase=${pathbase}-
fi

gitdesc=`git describe --always ${cmt}`

filename=${reponame}-${pathbase}${gitdesc}.zip

echo Archive commit ${shortcmt} of folder ${path} to ${outdir}/${filename}

git archive -o ${outdir}/${filename} ${shortcmt} ${path}

echo Done

