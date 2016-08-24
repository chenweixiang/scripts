import os
import sys

#
# This script is used to find certain clearcase versions, which has label specified by sys.argv[1] and has not label sys.argv[2], for instance:
# os.system("cleartool find /vobs/umts_fw_dev/units/ -version 'lbtype(OINT_FW_3G_AM_6360_V2_ES2_081_140702_202.427.000) && ! lbtype(OINT_FW_3G_AM_6360_V2_ES2_080_140624_202.426.000)' -print")
#

#
# Usage:
# python ~/script/clearcase-ls-commit-helper.py OINT_FW_3G_AM_6360_V2_ES2_081_140702_202.427.000 OINT_FW_3G_AM_6360_V2_ES2_080_140624_202.426.000
#

ctcmd="cleartool find /vobs/umts_fw_dev/units/ -version 'lbtype("+sys.argv[1]+") && ! lbtype("+sys.argv[2]+")' -print"
os.system(ctcmd)

