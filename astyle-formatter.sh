#!/bin/bash

################################################################################
# This script is used to format C/C++ source code via Artistic Style tool.     #
#                                                                              #
# Artistic Style Project Page:  http://astyle.sourceforge.net/                 #
# Artistic Style SourceForge :  http://sourceforge.net/projects/astyle/        #
################################################################################

#-------------------------------------------------------------------------------
# 1) Global variables
#-------------------------------------------------------------------------------

# Script name and location of this script
scriptName="astyle-formatter.sh"
scriptLocation=""

# Location of astyle
astyleName="astyle"
astyleBinary=""
astyleChoiceOne="No"
astyleChoiceTwo="No"

# Source file specified by option '-f <file>'
sourceFile=""

# Default path if option '-d <path>' is not specified
path=`pwd`

# Default wildcard if option '-w <wildcard>' is not specified
wildcard="*.h *.hpp *.hxx *.c *.cc *.cxx *.c++"

# Case insensitive by default if option '-n' is not specified
caseSensitive="No"

# Don't search subdirectory of specified directory if option '-r' is not specified
recursive="No"
findOptionMaxdepth="-maxdepth 1"

# Don't print debug information by default if option '-v' is not specified
verbose="No"

# !!! IMPORTANT: astyle options which impact on the result of source file !!!
# Refer to http://astyle.sourceforge.net/astyle.html for more information of those options.
#
# -c  : Converts tabs into spaces in the non-indentation part of the line.
# -j  : Add braces to unbraced one line conditional statements (e.g. 'if', 'for', 'while'...).
# -n  : Do not retain a backup of the original file. The original file is purged after it is formatted.
# -p  : Insert space padding around operators. This will also pad commas.
# -y  : Closing header braces are always broken when --style=allman.
# -H  : Insert space padding between a header (e.g. 'if', 'for', 'while'...) and the following paren.
# -Y  : Indent C++ comments beginning in column one. This option will allow the comments to be indented with the code.
# -xb : Break one line headers (e.g. 'if', 'while', 'else', ...) from a statement residing on the same line.
# -xf : Attach the return type to the function name. This option is for the function definitions.
# -xh : Attach the return type to the function name. This option is for the function declarations or signatures. 
# -xg : Insert space padding after commas. This is not needed if pad-oper (option '-p') is used.
# -xV : Attach the closing 'while' of a 'do-while' statement to the closing brace.
#
astyleOptions="--style=allman --indent=spaces=4 -c -j -n -p -y -H -Y -xb -xf -xh -xg -xV"

#-------------------------------------------------------------------------------
# 2) Usage
#-------------------------------------------------------------------------------

function usage(){
    echo
    echo "Usage:"
    echo "${scriptName} [-b <astyle> | -c] [-h]"
    echo "${scriptName} [-b <astyle> | -c] [-f <file>] [-v]"
    echo "${scriptName} [-b <astyle> | -c] [-d <path>] [-w <wildcard>] [-n] [-r] [-v]"
    echo
    echo "-b <astyle> | -c"
    echo "    Specify the location of executable astyle if it's not installed on your"
    echo "    server yet and you want to specify the location of executable astyle."
    echo "    If '-b <astyle>' is specified, use the <astyle> as the executable astyle."
    echo "    Otherwise, if '-c' is specified, the executable astyle is located in the"
    echo "    same directory with this script. Otherwise, use the astyle on the server."
    echo "    Note that the option '-b <astyle>' has higher priority than '-c' if both"
    echo "    of them are specified."
    echo
    echo "-f <file>"
    echo "    Specify the file you want to format. In order to reach the file, absolute"
    echo "    path or relative path should be included in <file>. Note that if you want"
    echo "    to format all files of a specific commit <commit>, execute the following"
    echo "    commit:"
    echo "    $ ~/scripts/git-ls.sh -n -c <commit> | xargs -i ~/scripts/astyle-formatter.sh -f {}"
    echo
    echo "-d <path>"
    echo "    Specify the directory of source files you want to format. In order to reach"
    echo "    the directory, absolute path or relative path should be included in it."
    echo "    If '-d <path>' is not specified, use current directory by default."
    echo "    If '-w <wildcard>' is not specified, format C and C++ source files by default."
    echo "    That's the suffix of source files are listed below with case insensitive:"
    echo "        *.h, *.hpp, *.hxx, *.c, *.cc, *.cxx, *.c++"
    echo "    Otherwise, use specified <wildcard> to find corresponding source files."
    echo
    echo "-w <wildcard>"
    echo "    Specify the wildcard to find source files in specified directory. Note that"
    echo "    if multiple wildcards are specified, they should be included in single quote"
    echo "    (') or double quotes (\")"
    echo
    echo "-n"
    echo "    By default, case insensitive in <wildcard>. Use option '-n' to make case"
    echo "    sensitive in <wildcard>."
    echo
    echo "-r"
    echo "    Find all source files met the <wildcard> rules in all specified directory"
    echo "    and its sub-directories."
    echo
    echo "-v"
    echo "    Show more debug information of this script."
    echo
    echo "-h"
    echo "    Show the usage of this script."
    echo
}

#-------------------------------------------------------------------------------
# 3) Check script options
#-------------------------------------------------------------------------------

while getopts "b:f:d:w:cnrvh" arg
do
    case ${arg} in
        b)  # -b <astyle>
            astyleChoiceOne="Yes"
            astyleChoiceOneBinary=${OPTARG}
            ;;
        c)  # -c
            astyleChoiceTwo="Yes"
            ;;
        f)  # -f <file>
            sourceFile=${OPTARG}
            ;;
        d)  # -d <path>
            path=${OPTARG}
            ;;
        w)  # -w <wildcard>
            wildcard=${OPTARG}
            ;;
        n)  # -n
            caseSensitive="Yes"
            ;;
        r)  # -r
            recursive="Yes"
            findOptionMaxdepth=""
            ;;
        v)  # -v
            verbose="Yes"
            ;;
        h)  # -h
            usage
            exit 1
            ;;
        ?)  # unkonw argument
            echo "ERROR: Unkonw argument"
            exit 1
            ;;
    esac
done

# Get the location of current script
function getLocCurScript() {
    SOURCE="${BASH_SOURCE[0]}"
    while [ -h "${SOURCE}" ]; do        # resolve $SOURCE until the file is no longer a symlink
        TARGET="$(readlink "${SOURCE}")"
        if [[ ${TARGET} == "/*" ]]; then
            if [ ${verbose} == "Yes" ]; then
                echo "INFO: SOURCE '${SOURCE}' is an absolute symlink to '${TARGET}'"
            fi
            SOURCE="${TARGET}"
        else
            DIR="$( dirname "${SOURCE}" )"
            if [ ${verbose} == "Yes" ]; then
                echo "INFO: SOURCE '${SOURCE}' is a relative symlink to '${TARGET}' (relative to '${DIR}')"
            fi
            SOURCE="${DIR}/${TARGET}"   # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
        fi
    done

    if [ ${verbose} == "Yes" ]; then
        echo "INFO: SOURCE is '${SOURCE}'"
    fi

    RDIR="$( dirname "${SOURCE}" )"
    DIR="$( cd -P "$( dirname "${SOURCE}" )" && pwd )"
    if [ ${verbose} == "Yes" ]; then
        if [ "${DIR}" != "${RDIR}" ]; then
            echo "INFO: DIR '${RDIR}' resolves to '${DIR}'"
        fi
        echo "INFO: DIR is '${DIR}'"
    fi

    # Update the location of this script
    scriptLocation=${DIR}
}

# Option "-b <astyle>" has higher priority than "-c" if both of them are specified
if [ ${astyleChoiceOne} == "Yes" ]; then
    astyleBinary=${astyleChoiceOneBinary}
elif [ ${astyleChoiceTwo} == "Yes" ]; then
    getLocCurScript
    astyleBinary="${scriptLocation}/astyle"
else	# default astyle on system
	astyleBinary=`which ${astyleName}`
	if [ x${astyleBinary} == x ]; then
		echo "ERROR: No ${astyleName} is found on system!"
		exit 1
	fi
fi

# Check the executable astyle is exist
if [ ! -f ${astyleBinary} ]; then
    echo "ERROR: Cannot find astyle binary ${astyleBinary} on system!"
    exit 1
fi

# The information of choosen executable astyle
whichAstyleBinary=`which ${astyleBinary}`

#-------------------------------------------------------------------------------
# 4) Use astyle to format specified source files
#-------------------------------------------------------------------------------

if [ x${sourceFile} == x ]; then
    # Format: ${scriptName} [-b <astyle>] [-d <path>] [-w <wildcard>] [-i] [-r] [-v]

    # Case sensitive or not, which impact the option of find command
    if [ ${caseSensitive} == "Yes" ]; then
        findCaseSensitive="-name"
    else
        findCaseSensitive="-iname"
    fi

    # Combine find options together
    findOptionName=""
    firstItem="Yes"
    for wcard in ${wildcard}; do
        if [ ${firstItem} == "Yes" ]; then
            findOptionName="${findOptionName} ${findCaseSensitive} ${wcard}"
        else
            findOptionName="${findOptionName} -o ${findCaseSensitive} ${wcard}"
        fi
        firstItem="No"
    done
    if [ ${verbose} == "Yes" ]; then
        echo "Astyle binary  : ${whichAstyleBinary}"
        echo "Astyle version : `${whichAstyleBinary} --version`"
        echo "Astyle options : ${astyleOptions}"
        echo "Path           : ${path}"
        echo "Wildcard       : ${wildcard}"
        echo "Find options   : ${findOptionName}"
    fi

    # Search specified source files and format them
    find ${path} ${findOptionMaxdepth} ${findOptionName} | xargs ${astyleBinary} ${astyleOptions}
else
    # Format: ${scriptName} [-b <astyle>] [-f <file>] [-v]
    if [ -f ${sourceFile} ]; then
        if [ ${verbose} == "Yes" ]; then
            echo "Astyle binary  : ${whichAstyleBinary}"
            echo "Astyle version : `${whichAstyleBinary} --version`"
            echo "Astyle option  : ${astyleOptions}"
            echo "Inputted file  : ${sourceFile}"
        fi
        ${astyleBinary} ${astyleOptions} ${sourceFile}
    else
        echo "ERROR: Input file ${sourceFile} doesn't exist!"
    fi
fi

