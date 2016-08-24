#!/bin/bash

################################################################################
#
# Usage: clearcase-ls-commit.sh <commit>
#
# The input parameter <commit> can be one of option:
# * help: Print usage
# * Commit label: Commit Label from UTP "Commit Label(s)" field of Commit/Publis section
#
################################################################################

OPTION1=$1
if [ "OPTION1" == "help" ]; then
    echo "NAME"
    echo "    pcl.sh - Print Commit Label information"
    echo
    echo "SYNOPSIS"
    echo "    ./pcl.sh [option]"
    echo
    echo "DESCRIPTION"
    echo "    Print specific commit label information, and related command used for propagate ticket."
    echo
    echo "    help"
    echo "        print this usage."
    echo
    echo "    Commit-Label"
    echo "        Specify commit label, which can be found in Commit Label(s) field of UTP Commit/Publish section."
    echo
    echo "AUTHOR"
    echo "   Written by Chen WeixiangX."
    echo
    echo "REPORTING BUGS"
    echo "   Report bugs to <weixiangx.chen@intel.com>."
    echo
    exit 0
fi


COMMITLABEL=$OPTION1
if [ "$COMMITLABEL" == "" ]; then
    echo "*** ERROR: Input commit lable is empty!"
    exit 1
fi


#
# Find private branch of specific commit
#
VERSIONFORMATHEADER=`find /vobs/umts_fw_dev/units/ -ignore_readdir_race -nowarn -name "*versionformat.h"`
if [ "$VERSIONFORMATHEADER" == "" ]; then
    echo "*** ERROR: Cannot find XXversionformat.h!"
    exit 2
fi

VERSIONFORMAT=`ct find $VERSIONFORMATHEADER -version 'lbtype('$COMMITLABEL')' -print`

# If the specified version on *versionformat.h has multiple labels, then
# it's not possible to use old method to find correct commit
LABELS=`ct desc -short -alabel -all $VERSIONFORMAT`
LABELS_CNT=`echo "$LABELS" | wc -w`
if (( $LABELS_CNT != 1 )); then
    echo
    echo "*** INFO: Multiple labels on" $VERSIONFORMAT

    # Find the label that is committed right before the speicified one
    LABELS_TMP1=${LABELS#*$COMMITLABEL}
    LABELS_CNT_TMP1=`echo "$LABELS_TMP1" | wc -w`

    # If the specified label is not the earliest one on the version, then use below command to find committed files
    # ct find . -version 'lbtype($COMMITLABEL) && ! lbtype($PRE_COMMITLABEL)' -print
    if (( $LABELS_CNT_TMP1 > 0 )); then
        PRE_COMMITLABEL=`echo $LABELS_TMP1 | cut -d ' ' -f 1`
        if [ "$PRE_COMMITLABEL" != "" ]; then
            echo "*** INFO: Run below command to find committed files with label $COMMITLABEL and without label $PRE_COMMITLABEL:"
            CTCMD="cleartool find /vobs/umts_fw_dev/units/ -version 'lbtype($COMMITLABEL) && ! lbtype($PRE_COMMITLABEL)' -print"
            echo $CTCMD
            echo
            COMMITTEDVERSION=`python ~/script/oc5/pcl_helper.py $COMMITLABEL $PRE_COMMITLABEL`
            if [ "$COMMITTEDVERSION" != "" ]; then
                # print committed versions
                echo "###############################################################################"
                echo "# Committed version with label" $COMMITLABEL
                echo "###############################################################################"
                for cversion in $COMMITTEDVERSION
                do
                    echo $cversion
                    VER_FOR_PRIVATE_BR=$cversion
                done
                echo
                # Print commands used to compare committed version
                echo "###############################################################################"
                echo "# Compare command for committed version"
                echo "###############################################################################"
                for cversion in $COMMITTEDVERSION
                do
                    echo "ct diff -g -pre" $cversion "&"
                done
                echo
                # find private branch
                HYPERLINK=`ct desc -short -ahlink  -all $VER_FOR_PRIVATE_BR`
                HYPERLINK_TMP1=${HYPERLINK#*<-}
                HYPERLINK_TMP2=${HYPERLINK_TMP1%->*}
                HYPERLINK_TMP3=${HYPERLINK_TMP2%/*}
                PRIVATEBRANCH=${HYPERLINK_TMP3##*/}
                if [ "$PRIVATEBRANCH" == "" ]; then
                    echo "*** ERROR: Cannot find Hyperlink to" $ER_FOR_PRIVATE_BR
                    exit 3
                fi
                # Find latest version on private branch
                LATESTVERSION=`ct find /vobs/umts_fw_dev/units/ -version 'version(.../'$PRIVATEBRANCH'/LATEST)' -print`
                echo "###############################################################################"
                echo "# Latest version on branch" $PRIVATEBRANCH
                echo "###############################################################################"
                for str in $LATESTVERSION
                do
                    MODIFIEDFILES+=${str%@@*}" "
                    echo $str
                done
                echo
                # Print commands used to create merge arrow
                echo "###############################################################################"
                echo "# Check-out command"
                echo "###############################################################################"
                echo "cleartool co -nc \`cleartool find /vobs/umts_fw_dev/units/ -version 'lbtype($COMMITLABEL) && ! lbtype($PRE_COMMITLABEL)' -nxname -print\`"
                echo
                # Print commands used to create merge arrow
                echo "###############################################################################"
                echo "# Create merge arrow command"
                echo "# from latest version on branch $PRIVATEBRANCH to current version"
                echo "###############################################################################"
                for lv in $LATESTVERSION
                do
                    mfile=${lv%@@*}
                    if [ "${mfile:0-15:15}" != "versionformat.h" ]; then
                       echo "ct merge -ndata -to $mfile -version ${lv#*@@}"
                    fi
                done
                echo
            else
                echo
                echo "*** ERROR: Cannot find versions with label $COMMITLABEL and without label $PRE_COMMITLABEL"
            fi
        fi

        exit 0
    fi

    # Otherwise, if the speicified label is the earliest one on the version, then continue process by old method!
fi

HYPERLINK=`ct desc -short -ahlink  -all $VERSIONFORMAT`
HYPERLINK_TMP1=${HYPERLINK#*<-}
HYPERLINK_TMP2=${HYPERLINK_TMP1%->*}
HYPERLINK_TMP3=${HYPERLINK_TMP2%/*}
PRIVATEBRANCH=${HYPERLINK_TMP3##*/}
if [ "$PRIVATEBRANCH" == "" ]; then
    echo "*** ERROR: Cannot find Hyperlink to" $VERSIONFORMAT
    exit 3
fi


#
# Print basic information
#
echo 
echo "###############################################################################"
echo "# Basic information"
echo "###############################################################################"
echo "Commit label:" $COMMITLABEL
echo "Private branch:" $PRIVATEBRANCH
echo


#
# Find latest version on private branch
#
LATESTVERSION=`ct find /vobs/umts_fw_dev/units/ -version 'version(.../'$PRIVATEBRANCH'/LATEST)' -print`
echo "###############################################################################"
echo "# Latest version on branch" $PRIVATEBRANCH
echo "###############################################################################"
for str in $LATESTVERSION
do
    MODIFIEDFILES+=${str%@@*}" "
    echo $str
done
echo

#
# Find committed versions
#
for mfile in $MODIFIEDFILES
do
    COMMITTEDVERSION+=`ct find $mfile -version 'lbtype('$COMMITLABEL')' -print`" "
done

if [ "$COMMITTEDVERSION" == "" ]; then
    echo "*** ERROR: Cannot find committed version!"
    exit 4
fi

echo "###############################################################################"
echo "# Committed version with label" $COMMITLABEL
echo "###############################################################################"
for cversion in $COMMITTEDVERSION
do
    echo $cversion
done
echo


#
# Print commands used to compare committed version
#
echo "###############################################################################"
echo "# Compare command for committed version"
echo "###############################################################################"
for cversion in $COMMITTEDVERSION
do
    echo "ct diff -g -pre" $cversion "&"
done
echo


#
# Print commands used to compare committed version with current version
#
echo "###############################################################################"
echo "# Compare command for committed version with current version"
echo "###############################################################################"
for cversion in $COMMITTEDVERSION
do
    echo "ct diff -g" $cversion ${cversion%@@*} "&"
done
echo


#
# Print commands used to checkout version
#
echo "###############################################################################"
echo "# Checkout command for your private branch"
echo "###############################################################################"
CMD="ct co -nc \`ct find . -all -nxname -version 'version(.../$PRIVATEBRANCH/LATEST)' -print\` "
echo $CMD
echo

for mf in $MODIFIEDFILES
do
    echo "ct co -nc" $mf
done
echo


#
# Print commands used to create merge arrow
#
echo "###############################################################################"
echo "# Create merge arrow command"
echo "# from latest version on branch $PRIVATEBRANCH to current version"
echo "###############################################################################"
for lv in $LATESTVERSION
do
    mfile=${lv%@@*}
    if [ "${mfile:0-15:15}" != "versionformat.h" ]; then
       echo "ct merge -ndata -to $mfile -version ${lv#*@@}"
    
fi
done
echo


#
# Print commands used to list files checked-out in your view
#
echo "###############################################################################"
echo "# List checked-out files in your current view"
echo "###############################################################################"
CVIEW=`ct lsview -cview`
echo "Current view:"
echo   "`ct lsview -cview`"
echo
echo "ct lsco -cview -a -short"
echo "ct lsco -cview -a"
echo


#
# Print commands used to checkin your files
#
echo "###############################################################################"
echo "# Check-in your files"
echo "###############################################################################"
echo "Create file comment.txt and put check-in comments in it, then run command:"
echo "ct ci -cfile comment.txt "'`'"ct lsco -cview -a -short"'`'
CHECKOUTS=`ct lsco -cview -a -short`
if [ "$CHECKOUTS" != "" ]; then
    echo
    echo "Or, run below seperate commands instead:"
    for cofile in $CHECKOUTS
    do
       echo "ct ci -cfile comment.txt $cofile"
    done
fi
echo

