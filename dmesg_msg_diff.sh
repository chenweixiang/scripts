#!/bin/bash

#
# Copyright(c) Chen Weixiang <weixiang.chen@gmail.com>
#
# License: GPLv2
#

if [ "$1" == "" ] || [ "$2" == "" ]; then
        echo "Usage: $0 <uname -r> <uname -r>"
        exit -1
fi

rel1=$1
rel2=$2

echo "=== diff dmesg level emergency (0) <$rel1 : $rel2> ===" >> dmesg_checks_results
diff $rel1/0_dmesg_emerg $rel2/0_dmesg_emerg >> dmesg_checks_results
echo -e "\n" >> dmesg_checks_results

echo "=== diff dmesg level alert (1) <$rel1 : $rel2> ===" >> dmesg_checks_results
diff $rel1/1_dmesg_alert $rel2/1_dmesg_alert >> dmesg_checks_results
echo -e "\n" >> dmesg_checks_results

echo "=== diff dmesg level critical (2) <$rel1 : $rel2> ===" >> dmesg_checks_results
diff $rel1/2_dmesg_crit $rel2/2_dmesg_crit >> dmesg_checks_results
echo -e "\n" >> dmesg_checks_results

echo "=== diff dmesg level err (3) <$rel1 : $rel2> ===" >> dmesg_checks_results
diff $rel1/3_dmesg_err $rel2/3_dmesg_err >> dmesg_checks_results
echo -e "\n" >> dmesg_checks_results

echo "=== diff dmesg level warn (4) <$rel1 : $rel2> ===" >> dmesg_checks_results
diff $rel1/4_dmesg_warn $rel2/4_dmesg_warn >> dmesg_checks_results
echo -e "\n" >> dmesg_checks_results

echo "=== diff dmesg level notice (5) <$rel1 : $rel2> ===" >> dmesg_checks_results
diff $rel1/5_dmesg_notice $rel2/5_dmesg_notice >> dmesg_checks_results
echo -e "\n" >> dmesg_checks_results

echo "=== diff dmesg level info (6) <$rel1 : $rel2> ===" >> dmesg_checks_results
diff $rel1/6_dmesg_info $rel2/6_dmesg_info >> dmesg_checks_results
echo -e "\n" >> dmesg_checks_results

echo "=== diff dmesg level debug (7) <$rel1 : $rel2> ===" >> dmesg_checks_results
diff $rel1/7_dmesg_debug $rel2/7_dmesg_debug >> dmesg_checks_results
echo -e "\n" >> dmesg_checks_results

echo "=== diff dmesg level kern <$rel1 : $rel2> ===" >> dmesg_checks_results
diff $rel1/98_dmesg_kern $rel2/98_dmesg_kern >> dmesg_checks_results
echo -e "\n" >> dmesg_checks_results

echo "=== diff dmesg level all <$rel1 : $rel2> ===" >> dmesg_checks_results
diff $rel1/99_dmesg_all $rel2/99_dmesg_all >> dmesg_checks_results
echo -e "\n" >> dmesg_checks_results



