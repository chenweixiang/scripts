#!/bin/bash

#-------------------------------------------------------------------------------
# This Bash script is used to zip a specified commit in current repository.
# The commit is specified by input parameter $1. Use HEAD as the commit if
# no input parameter $1 is specified.
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# 1) Get the commit-id and output-dir
#-------------------------------------------------------------------------------

# Set default commit-id and output-dir
commitId="HEAD"
outputDir="."
path=`pwd`
withSubmodule="No"

usage="git-archive.sh { [-c commit-id] [-p path ] [-o output-dir] [-m] | [-h] }"

# Get commit-id and output-dir from input parameters
while getopts "c:p:o:mh" arg
do
    case $arg in
        c)  # -c <commit-id>
            commitId=$OPTARG
            ;;
        p)  # -p <path>
            path=$OPTARG
            ;;
        o)  # -o <output-dir>
            outputDir=$OPTARG
            ;;
        m)  # -m: archive submodules at the same time
            withSubmodule="Yes"
            ;;
        h)  # help
            echo ${usage}
            exit 1
            ;;
        ?)  # unkonw argument
            echo "Unkonw argument"
            exit 1
            ;;
    esac
done

#-------------------------------------------------------------------------------
# 2) Archive the specified commit ID 'shortCommitId' to 'fileName'
#-------------------------------------------------------------------------------

# Get short commit ID corresponding to commitId
shortCommitId=`git rev-parse --short ${commitId}`

# Get the top directory of the repo
repoRootDir=`git rev-parse --show-toplevel`

# Get repo name
repoName=`basename ${repoRootDir}`

# Get commit describe corresponding to commitId
commitDesc=`git describe --always ${commitId}`

# Assemble file name
fileName=${repoName}-${commitDesc}

# Create temperay directory to collect all output
temperayDir=${outputDir}/${fileName}
echo Create temperay directory ${temperayDir}
mkdir -p ${temperayDir}

# Archive the main repo
echo Archive commit ${shortCommitId} of repo ${repoName} to ${temperayDir}
cd ${repoRootDir}
git archive --format=tar ${shortCommitId} ${path} | (cd ${temperayDir} && tar xf -)

# Update submodules corresponding to commit ID 'shortCommitId' and check submodules status
if [ ${withSubmodule} == "Yes" ]; then
    echo Update submodules and current submodules status:
    git submodule update --init --recursive
    git submodule

    # Archive each submodule
    repoSubmodules=`git submodule | awk '{print $2}'`
    for submodule in ${repoSubmodules}; do
        submodulePath=${repoRootDir}/${submodule}
        echo Archive submodule ${submodule} in directory ${submodulePath}
        # echo cd ${submodulePath}
        cd ${submodulePath}
        git archive --format=tar --prefix=${submodule}/ HEAD | (cd ${temperayDir} && tar xf -)
    done
fi

# Compress all modules to .tar.gz
echo Comparess all output to ${fileName}.tar.gz
cd ${outputDir}
tar cf ${fileName}.tar.gz ${fileName}

echo Remove temperay directory ${temperayDir}
rm -rf ${fileName}

echo Done

