#!/bin/bash

#
# Copyright(c) Chen Weixiang <weixiang.chen@gmail.com>
#
# License: GPLv2
#

release=`uname -r`

echo "mkdir $release"
mkdir $release

echo "dmesg -t -l emerg > $release/0_dmesg_emerg"
dmesg -t -l emerg > $release/0_dmesg_emerg

echo "dmesg -t -l alert > $release/1_dmesg_alert"
dmesg -t -l alert > $release/1_dmesg_alert

echo "dmesg -t -l crit > $release/2_dmesg_crit"
dmesg -t -l crit > $release/2_dmesg_crit

echo "dmesg -t -l err > $release/3_dmesg_err"
dmesg -t -l err > $release/3_dmesg_err

echo "dmesg -t -l warn > $release/4_dmesg_warn"
dmesg -t -l warn > $release/4_dmesg_warn

echo "dmesg -t -l warn > $release/dmesg_5_notice"
dmesg -t -l notice > $release/5_dmesg_notice

echo "dmesg -t -l info > $release/6_dmesg_info"
dmesg -t -l info > $release/6_dmesg_info

echo "dmesg -t -l debug > $release/7_dmesg_debug"
dmesg -t -l debug > $release/7_dmesg_debug

echo "dmesg -t -k > $release/98_dmesg_kern"
dmesg -t -k > $release/98_dmesg_kern

echo "dmesg -t > $release/99_dmesg_all"
dmesg -t > $release/99_dmesg_all


