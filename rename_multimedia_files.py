#!/usr/bin/env python3
# -*- coding: utf-8 -*-

'''
批量修改照片文件名称的Python脚本程序。
遍历指定目录（含子目录）的照片文件，并
根据拍照时间将照片文件名修改为以下格式：
    IMG_20140315_091230_00.JPG
如果存在重名文件，则尝试如下文件名：
    IMG_20140315_091230_01.JPG
    ...
    IMG_20140315_091230_99.jpg

本程序需要安装下列模块：
    $ sudo apt install python3-pip
    $ pip3 --version

    $ sudo pip3 install exifread
    $ pip3 show exifread
      Name: ExifRead
      Version: 2.3.2
      Summary: Read Exif metadata from tiff and jpeg files.
      Home-page: https://github.com/ianare/exif-py
      Author: Ianaré Sévi
      Author-email: ianare@gmail.com
      License: BSD
      Location: /usr/local/lib/python3.8/dist-packages
      Requires:
      Required-by:

    $ pip3 install python-dateutil
    $ pip3 show python-dateutil
      Name: python-dateutil
      Version: 2.8.1
      Summary: Extensions to the standard Python datetime module
      Home-page: https://dateutil.readthedocs.io
      Author: Gustavo Niemeyer
      Author-email: gustavo@niemeyer.net
      License: Dual License
      Location: /home/chenwx/.local/lib/python3.8/site-packages
      Requires: six
      Required-by:

    $ sudo apt install exiftool
'''

import os
import sys
import stat
import time
import exifread
import argparse
import subprocess
import shutil
from datetime import datetime
from dateutil import tz
from pathlib import Path
from collections import defaultdict


# File type
IMG_FILE_TYPE = "IMG_"
VID_FILE_TYPE = "VID_"
AUD_FILE_TYPE = "AUD_"

# Extension names
IMG_SUFFIX_FILTER = [ '.JPG', '.PNG', '.BMP', '.JPEG' ]
VID_SUFFIX_FILTER = [ '.MP4', '.MPG', '.MOV', '.AVI' ]
AUD_SUFFIX_FILTER = [ '.M4A', '.WAV' ]


# Global variables for input parameters
g_is_recursive      = False
g_is_execute        = False
g_single_file       = ""
g_use_modified_date = False
g_handle_photo      = False
g_handle_vedio      = False
g_handle_audio      = False
g_is_verbose        = False


# China Time Zone
CN_TIME_ZONE = "+08:00"

# Suffix of output folder
OUTPUT_DIR_SUFFIX = "_RENAME_MULTIMEDIA"


def parse_arguments():
    # Parse arguments
    parser = argparse.ArgumentParser(description='')
    parser.add_argument("-d", "--directory", help="Specify directory.")
    parser.add_argument("-r", "--recursive", action="store_true", help="Recursive all sub-directories.")
    parser.add_argument("-e", "--execute", action="store_true", help="Execute the rename action.")
    parser.add_argument("-f", "--file", help="Specify a file.")
    parser.add_argument("-m", "--modified", action="store_true", help="Use modified date if EXIF data missing.")
    parser.add_argument("-a", "--all", action="store_true", help="Process photos and vedios.")
    parser.add_argument("-p", "--photo", action="store_true", help="Process photos.")
    parser.add_argument("-v", "--vedio", action="store_true", help="Process vedios.")
    parser.add_argument("-V", "--verbose", action="store_true", help="Print debug traces")
    args = parser.parse_args()

    # -r, --recursive
    global g_is_recursive
    if args.recursive:
        g_is_recursive = True

    # -e, --execute
    global g_is_execute
    if args.execute:
        g_is_execute = True

    # -f, --file
    global g_single_file
    if args.file:
        g_single_file = args.file

    # -m, --modified
    global g_use_modified_date
    if args.modified:
        g_use_modified_date = True

    # -a, --all
    global g_handle_photo
    global g_handle_vedio
    global g_handle_audio
    if args.all:
        g_handle_photo = True
        g_handle_vedio = True
        g_handle_audio = True

    # -p, --photo
    if args.photo:
        g_handle_photo = True

    # -v, --vedio
    if args.vedio:
        g_handle_vedio = True

    # -V, --verbose
    global g_is_verbose
    if args.verbose:
        g_is_verbose = True

    # -d, --directory
    path_list = []
    if args.directory:
        for path in args.directory.split():
            path_obj = Path(path)
            if path_obj.exists():
                source_path_str = path_obj.resolve()
                if source_path_str not in path_list:
                    path_list.append(source_path_str)
    else:
        source_path_str = Path().absolute()
        path_list.append(source_path_str)

    print("g_is_recursive      :", g_is_recursive)
    print("g_is_execute        :", g_is_execute)
    print("g_single_file       :", g_single_file)
    print("g_use_modified_date :", g_use_modified_date)
    print("g_handle_photo      :", g_handle_photo)
    print("g_handle_vedio      :", g_handle_vedio)
    print("g_handle_audio      :", g_handle_audio)
    print('\n')

    return path_list


def scan_path(path):
    global g_is_recursive
    global g_is_verbose

    source_file_list = []
    sub_dir_list = []

    curr_path = Path(path)
    curr_path_str = curr_path.resolve()

    if g_is_verbose == True:
        print('\n')
        print("curr_path_str:")
        print(curr_path_str)

    for item in curr_path.iterdir():
        if item.is_file() and (not str(item.name).startswith('.')):
            source_file_list.append(curr_path_str / item)
        elif item.is_dir() and g_is_recursive and (not str(item.name).startswith('.')):
            sub_dir_list.append(curr_path_str / item)

    if (g_is_recursive == True) and (g_is_verbose == True):
        print('\n')
        print("sub_dir_list:")
        if len(sub_dir_list) > 0:
            for sub_dir in sub_dir_list:
                print(sub_dir)
        else:
            print("Empty!")

    if g_is_recursive == True:
        for dir in sub_dir_list:
            source_file_list.extend(scan_path(dir))

    return source_file_list


def generate_target_file_dict(path, source_file_list):
    global g_is_verbose

    target_file_dict = defaultdict(list)

    target_path = Path(str(path) + OUTPUT_DIR_SUFFIX)
    #print("target_path:", target_path)
    if Path(target_path).exists():
        print(target_path, "already exists, abort!")
        sys.exit()

    for source_file in source_file_list:
        ret_val, target_file_name = generate_target_file_name(source_file)
        if ret_val == False:
            print("ret_val:", ret_val, "for file:", str(source_file), "target_file_name:", target_file_name)

        source_file_sub_path = str(source_file.parent)[len(str(path))+1:]
        #print("source_file_sub_path:", source_file_sub_path)
        if len(source_file_sub_path) > 0:
            target_file = target_path.joinpath(source_file_sub_path).joinpath(target_file_name)
        else:
            target_file = target_path.joinpath(target_file_name)
        #print("target_file:", target_file)
        target_file_dict[target_file].append(source_file)

    return target_path, target_file_dict


def generate_target_file_name(source_file_name):
    # 根据照片的拍照时间生成新的文件名。如果获取不到拍照时间，则直接跳过
    try:
        fd = Path(source_file_name).open('rb')
        # print("open file: ", source_file_name)
    except:
        print("cannot open file ", source_file_name)
        sys.exit()

    # Default value
    ret_val = False
    new_file_name = source_file_name.name

    # 原文件信息
    file_name_str = Path(source_file_name).name
    f, e = os.path.splitext(file_name_str)

    file_type = ""

    # 根据文件扩展名，判断是否是需要处理的文件类型
    if e.upper() in IMG_SUFFIX_FILTER:
        file_type = IMG_FILE_TYPE
    elif e.upper() in VID_SUFFIX_FILTER:
        file_type = VID_FILE_TYPE
    elif e.upper() in AUD_SUFFIX_FILTER:
        file_type = AUD_FILE_TYPE
    else:
        print("Unsupported file extension ", e.upper(), "for file", str(source_file_name))
        return False, file_name_str

    my_data_format = file_type + '%Y%m%d_%H%M%S'
    if file_type == IMG_FILE_TYPE and g_handle_photo == True:
        # 如果取得Exif信息，则根据照片的拍摄日期重命名文件
        exif_tags = exifread.process_file(fd)
        if exif_tags:
            try:
                # 取得照片的拍摄日期，并转换成 yyyymmdd_hhmmss 格式
                t = exif_tags [ 'EXIF DateTimeOriginal' ]
                date_str = file_type + str(t).replace(":", "")[:8] + "_" + str(t)[11:].replace(":", "")
                # 生成新文件名
                new_file_name = os.path.join(date_str + e).upper()
                ret_val = True
            except:
                pass
    elif file_type == VID_FILE_TYPE and g_handle_vedio == True:
        exiftool_cmd = "exiftool " + file_name_str
        exiftool_val = subprocess.run(exiftool_cmd, shell=True, stderr=subprocess.PIPE, stdout=subprocess.PIPE)
        meta_data = str(exiftool_val.stdout).split("\\n")
        src_zone = tz.tzutc()
        dst_zone = tz.tzlocal()

        # For ".MP4":
        #   File Type                       : MP4
        #   File Type Extension             : mp4
        #   MIME Type                       : video/mp4
        #   Major Brand                     : MP4 v2 [ISO 14496-14]
        if e.upper() == ".MP4":
            for element in meta_data:
                if "Media Create Date" in element:
                    try:
                        mediaCreateDate = (element.split(" : ")[1])
                        utc_date_time = datetime.strptime(mediaCreateDate, '%Y:%m:%d %H:%M:%S')
                        utc_date_time = utc_date_time.replace(tzinfo=src_zone)
                        local_date_time = utc_date_time.astimezone(dst_zone)
                        date_str = local_date_time.strftime(my_data_format)
                        new_file_name = os.path.join(date_str + e).upper()
                        ret_val = True
                        break
                    except:
                        ret_val = False
                        break
        # For ".MPG":
        #   File Type                       : MPEG
        #   File Type Extension             : mpg
        #   MIME Type                       : video/mpeg
        elif e.upper() == ".MPG":
            for element in meta_data:
                if "File Modification Date/Time" in element:
                    try:
                        fileModificationDateTime = (element.split(" : ")[1])
                        modificationDateTime = fileModificationDateTime[:19]
                        time_zone = fileModificationDateTime[19:]
                        if time_zone == CN_TIME_ZONE:
                            local_date_time = datetime.strptime(modificationDateTime, '%Y:%m:%d %H:%M:%S')
                            date_str = local_date_time.strftime(my_data_format)
                            new_file_name = os.path.join(date_str + e).upper()
                            ret_val = True
                            break
                        else:
                            utc_date_time = datetime.strptime(modificationDateTime, '%Y:%m:%d %H:%M:%S')
                            utc_date_time = utc_date_time.replace(tzinfo=src_zone)
                            local_date_time = utc_date_time.astimezone(dst_zone)
                            date_str = local_date_time.strftime(my_data_format)
                            new_file_name = os.path.join(date_str + e).upper()
                            ret_val = True
                            break
                    except:
                        ret_val = False
                        break
        # For ".MOV":
        #   File Type                       : MOV
        #   File Type Extension             : mov
        #   MIME Type                       : video/quicktime
        #   Major Brand                     : Apple QuickTime (.MOV/QT)
        elif e.upper() == ".MOV":
            for element in meta_data:
                if "Creation Date" in element:
                    try:
                        creation_date = (element.split(" : ")[1])
                        creation_date_time = creation_date[:19]
                        time_zone = creation_date[19:]
                        if time_zone == CN_TIME_ZONE:
                            local_date_time = datetime.strptime(creation_date_time, '%Y:%m:%d %H:%M:%S')
                            date_str = local_date_time.strftime(my_data_format)
                            new_file_name = os.path.join(date_str + e).upper()
                            ret_val = True
                            break
                        else:
                            utc_date_time = datetime.strptime(creation_date_time, '%Y:%m:%d %H:%M:%S')
                            utc_date_time = utc_date_time.replace(tzinfo=src_zone)
                            local_date_time = utc_date_time.astimezone(dst_zone)
                            date_str = local_date_time.strftime(my_data_format)
                            new_file_name = os.path.join(date_str + e).upper()
                            ret_val = True
                            break
                    except:
                        ret_val = False
                        break
    elif file_type == AUD_FILE_TYPE and g_handle_audio == True:
        exiftool_cmd = "exiftool " + source_file_name
        exiftool_val = subprocess.run(exiftool_cmd, shell=True, stderr=subprocess.PIPE, stdout=subprocess.PIPE)
        meta_data = str(exiftool_val.stdout).split("\\n")
        src_zone = tz.tzutc()
        dst_zone = tz.tzlocal()

        # For ".M4A":
        #   File Type                       : M4A
        #   File Type Extension             : m4a
        #   MIME Type                       : audio/mp4
        #   Major Brand                     : Apple iTunes AAC-LC (.M4A) Audio
        if e.upper() == ".M4A":
            for element in meta_data:
                if "Create Date" in element:
                    try:
                        creation_date = (element.split(" : ")[1])
                        creation_date_time = creation_date[:19]
                        time_zone = creation_date[19:]
                        if time_zone == CN_TIME_ZONE:
                            local_date_time = datetime.strptime(creation_date_time, '%Y:%m:%d %H:%M:%S')
                            date_str = local_date_time.strftime(my_data_format)
                            new_file_name = os.path.join(date_str + e).upper()
                            ret_val = True
                            break
                        else:
                            utc_date_time = datetime.strptime(creation_date_time, '%Y:%m:%d %H:%M:%S')
                            utc_date_time = utc_date_time.replace(tzinfo=src_zone)
                            local_date_time = utc_date_time.astimezone(dst_zone)
                            date_str = local_date_time.strftime(my_data_format)
                            new_file_name = os.path.join(date_str + e).upper()
                            ret_val = True
                            break
                    except:
                        ret_val = False
                        break
        # For ".WAV":
        #   File Type                       : WAV
        #   File Type Extension             : wav
        #   MIME Type                       : audio/x-wav
        #   Encoding                        : Microsoft PCM
        elif e.upper() == ".WAV":
            for element in meta_data:
                if "File Modification Date/Time" in element:
                    try:
                        creation_date = (element.split(" : ")[1])
                        creation_date_time = creation_date[:19]
                        time_zone = creation_date[19:]
                        if time_zone == CN_TIME_ZONE:
                            local_date_time = datetime.strptime(creation_date_time, '%Y:%m:%d %H:%M:%S')
                            date_str = local_date_time.strftime(my_data_format)
                            new_file_name = os.path.join(date_str + e).upper()
                            ret_val = True
                            break
                        else:
                            utc_date_time = datetime.strptime(creation_date_time, '%Y:%m:%d %H:%M:%S')
                            utc_date_time = utc_date_time.replace(tzinfo=src_zone)
                            local_date_time = utc_date_time.astimezone(dst_zone)
                            date_str = local_date_time.strftime(my_data_format)
                            new_file_name = os.path.join(date_str + e).upper()
                            ret_val = True
                            break
                    except:
                        ret_val = False
                        break

    # 如果获取Exif信息失败，则采用该照片的创建日期重命名文件
    if ret_val == False and g_use_modified_date == True:
        state = os.stat(source_file_name)
        date_str = time.strftime(my_data_format, time.localtime(state[-2]))
        new_file_name = os.path.join(date_str + e).upper()
        ret_val = True

    return ret_val, new_file_name


def execute_rename_action(target_path, target_file_dict):
    global g_is_verbose

    num_of_copied_files = 0

    for (target_file, source_file_list) in target_file_dict.items():
        if not target_file.parent.exists():
            target_file.parent.mkdir(parents = True)

        if len(source_file_list) == 1:
            shutil.copy(source_file_list[0], target_file)
            num_of_copied_files += 1

            if g_is_verbose == True:
                print(str(source_file_list[0]), "->", str(target_file))
        else:
            target_file_dir = target_file.parent
            target_file_stem = target_file.stem
            target_file_suffix = target_file.suffix
            #print("target_file_dir:", target_file_dir, "target_file_stem:", target_file_stem, "target_file_suffix:", target_file_suffix)

            source_file_index = 0
            for source_file in source_file_list:
                target_file_name_with_index = target_file_stem + "_" + str(source_file_index).zfill(2) + target_file_suffix
                target_file_with_index = target_file_dir / target_file_name_with_index
                #print("source file:", source_file, "target_file_name_with_index:", target_file_name_with_index, "target_file_with_index:", target_file_with_index)

                shutil.copy(source_file, target_file_with_index)
                num_of_copied_files += 1
                source_file_index += 1

                if g_is_verbose == True:
                    print(str(source_file), "->", str(target_file_with_index))

    print("Number of files copied to", str(target_path), ":", num_of_copied_files)


if __name__ == "__main__":
    # Parse input arguments
    path_list = parse_arguments()

    if g_is_verbose == True:
        print('\n')
        print("path_list:")
        if len(path_list) > 0:
            for path in path_list:
                print(path)
        else:
            print("Empty!")

    # Loop path specified in input argument -d "path1 path2 .."
    for path in path_list:
        # Scan the path and put all files to source_file_list
        source_file_list = scan_path(path)

        # Print all files in source_file_list if input argument -V is specified
        if g_is_verbose == True:
            print('\n')
            print("source_file_list:")
            if len(source_file_list) > 0:
                for file in source_file_list:
                    print(file)
            else:
                print("Empty!")

        print("Number of source files in source_file_list :", len(source_file_list))

        # Generate target file name and put it in to target_file_dict
        target_path, target_file_dict = generate_target_file_dict(path, source_file_list)

        len_duplicated_key = 0
        len_duplicated_val = 0

        if len(target_file_dict) > 0:
            for target_file in target_file_dict:
                if len(target_file_dict[target_file]) > 1:
                    len_duplicated_key += 1
                    len_duplicated_val += len(target_file_dict[target_file])

        if g_is_verbose == True:
            print('\n')
            print("target_file_dict:")
            if len(target_file_dict) > 0:
                for target_file in target_file_dict:
                    print(target_file, str(target_file_dict[target_file]))
            else:
                print("Empty!")

        #print("Number of target files:", len(target_file_dict))
        #print("Number of target files with duplicated source files:", len_duplicated_key)
        print("Number of source files in target_file_dict :", len(target_file_dict) - len_duplicated_key + len_duplicated_val)

        if g_is_execute == True:
            execute_rename_action(target_path, target_file_dict)
