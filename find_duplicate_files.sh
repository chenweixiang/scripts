#!/bin/bash

################################################################################
#                                                                              #
# Find Duplicate Files in Current Folder                                       #
#                                                                              #
################################################################################

#
# Refer to 利用Linux查找重复文件(shell脚本) on
# https://blog.csdn.net/zixiaomuwu/article/details/50878383
#
find -not -empty -type f -printf "%s\n" | sort -rn |uniq -d | xargs -I{} -n1 find -type f -size {}c -print0 | xargs -0 md5sum | sort | uniq -w32 --all-repeated=separate | cut -b 36-

