#!/usr/bin/env python3
# -*- coding: utf-8 -*-

'''
批量修改照片文件名称的Python脚本程序。
遍历指定目录（含子目录）的照片文件，并
根据拍照时间将照片文件名修改为以下格式：
    IMG_20140315_091230.JPG
如果存在重名文件，则尝试如下文件名：
    IMG_20140315_091230_01.JPG
    ...
    IMG_20140315_091230_99.jpg

本程序需要安装ExifRead模块，如果未改装
改模块，可执行下列命令来安装：
    sudo apt install python3-pip
    pip3 --version
    sudo pip3 install exifread
'''

import os
import stat
import time
import exifread
import argparse
from pathlib import Path

# Extension Names
IMG_SUFFIX_FILTER = [ '.jpg', '.png', '.mpg', '.bmp', '.jpeg' ]
VID_SUFFIX_FILTER = [ '.mp4', '.mov', '.avi' ]

# Global Variables
isExecute = False
isRecursive = False

def parseArguments():
    # Parse arguments
    parser = argparse.ArgumentParser(description='')
    parser.add_argument("-d", "--directory", help="specify directory.")
    parser.add_argument("-e", "--execute", action="store_true", help="Execute the rename action.")
    parser.add_argument("-r", "--recursive", action="store_true", help="Recursive all sub-directories.")
    args = parser.parse_args()
    
    # -d, --directory
    path = "."
    if args.directory and Path(args.directory).exists():
        path = args.directory
    print("Path      :", os.path.abspath(path))
    
    # -e, --execute
    global isExecute
    if args.execute:
        isExecute = True
    print("Execute   :", isExecute)
    
    # -r, --recursive
    global isRecursive
    if args.recursive:
        isRecursive = True
    print("Recursive ：", isRecursive)
    print('\n')
    
    return path


def isTargetFileType(filename):
    # 根据文件扩展名，判断是否是需要处理的文件类型
    filename_nopath = os.path.basename(filename)
    f, e = os.path.splitext(filename_nopath)
    if e.lower() in IMG_SUFFIX_FILTER:
        return True, "IMG_"
    elif e.lower() in VID_SUFFIX_FILTER:
        return True, "VID_"
    else:
        return False, ""


def generateNewFileName(filename, prefix):
    # 根据照片的拍照时间生成新的文件名。如果获取不到拍照时间，则直接跳过
    try:
        if os.path.isfile(filename):
            fd = open(filename, 'rb')
        else:
            raise "[%s] is not a file!\n" % filename
    except:
        raise "unopen file[%s]\n" % filename
    
    # Default value
    retVal = False
    newFileName = ""
    
    # 如果取得Exif信息，则根据照片拍摄日期重命名文件; 否认则，直接跳过
    exifTags = exifread.process_file(fd)
    if exifTags:
        try:
            # 取得照片的拍摄日期，并转换成 yyyymmdd_hhmmss 格式
            t = exifTags [ 'EXIF DateTimeOriginal' ]
            dateStr = prefix + str(t).replace(":", "")[:8] + "_" + str(t)[11:].replace(":", "")
            
            # 生成新文件名
            dirname = os.path.dirname(filename)
            filename_nopath = os.path.basename(filename)
            f, e = os.path.splitext(filename_nopath)
            newFileName = os.path.join(dirname, dateStr + e).upper()
            
            # 如果新文件名与原文件名相同，则无需改名
            if newFileName == filename:
                retVal = False
            # 如果新文件名与其他文件重名，则在新文件明后加后缀 _01, _02, .., _99
            elif Path(newFileName).exists():
                for i in range(1, 100):
                    tmpDateStr = dateStr + "_" + str(i).zfill(2)
                    newFileName = os.path.join(dirname, tmpDateStr + e).upper()
                    if newFileName == filename:
                        retVal = False
                        break
                    elif Path(newFileName).exists() == False:
                        retVal = True
                        break
            else:
                retVal = True
        except:
            pass
    
    return retVal, newFileName


def scanDir(startdir):
    global isExecute
    global isRecursive
    
    # 遍历指定目录以及子目录，对满足条件的文件进行改名
    os.chdir(startdir)
    for obj in os.listdir(os.curdir):
        if os.path.isfile(obj):
            retVal, prefix = isTargetFileType(obj)
            if retVal:
                # 对满足过滤条件的文件进行改名处理
                retVal, newFileName = generateNewFileName(obj, prefix)
                if retVal:
                    try:
                        if isExecute == True:
                            os.rename(obj, newFileName)
                        print(os.path.abspath(obj), " => ", newFileName)
                    except:
                        print(os.path.abspath(obj), " => cannot rename to ", newFileName)
                else:
                    print(os.path.abspath(obj), " =>  No change")
        elif os.path.isdir(obj) and isRecursive == True:
            scanDir(obj)
            os.chdir(os.pardir)


if __name__ == "__main__":
    path = parseArguments()
    scanDir(path)

