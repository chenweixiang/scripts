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
import stat
import time
import exifread
import argparse
import subprocess
from datetime import datetime
from dateutil import tz
from pathlib import Path

# FILE_TYPE
IMG_FILE_TYPE = "IMG_"
VID_FILE_TYPE = "VID_"
AUD_FILE_TYPE = "AUD_"

# Extension Names
IMG_SUFFIX_FILTER = [ '.JPG', '.PNG', '.BMP', '.JPEG' ]
VID_SUFFIX_FILTER = [ '.MP4', '.MPG', '.MOV', '.AVI' ]
AUD_SUFFIX_FILTER = [ '.M4A', '.WAV' ]

# Global Variables
g_path_list         = []
g_is_recursive      = False
g_is_execute        = False
g_single_file       = ""
g_use_modified_date = False
g_handle_photo      = False
g_handle_vedio      = False
g_handle_audio      = False
g_use_abs_path      = False
g_is_quiet          = True

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
    parser.add_argument("-b", "--abspath", action="store_true", help="Print abspath.")
    parser.add_argument("-n", "--notquiet", action="store_true", help="Print all rename info.")
    args = parser.parse_args()

    # -d, --directory
    global g_path_list
    if args.directory:
        path_list = args.directory.split()
        for path in path_list:
            path_obj = Path(path)
            if path_obj.exists():
                path_str = path_obj.resolve()
                if path_str not in g_path_list:
                    g_path_list.append(path_str)
    else:
        g_path_list.append(Path().absolute())

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

    # -b, --abspath
    global g_use_abs_path
    if args.abspath:
        g_use_abs_path = True

    # -n, --notquiet
    global g_is_quiet
    if args.notquiet:
        g_is_quiet = False

    print("g_path_list         :", g_path_list)
    print("g_is_recursive      :", g_is_recursive)
    print("g_is_execute        :", g_is_execute)
    print("g_single_file       :", g_single_file)
    print("g_use_modified_date :", g_use_modified_date)
    print("g_handle_photo      :", g_handle_photo)
    print("g_handle_vedio      :", g_handle_vedio)
    print("g_handle_audio      :", g_handle_audio)
    print("g_use_abs_path      :", g_use_abs_path)
    print("g_is_quiet          :", g_is_quiet)
    print('\n')


def is_target_file_type(file_name):
    # 根据文件扩展名，判断是否是需要处理的文件类型
    file_name_no_path = os.path.basename(file_name)
    f, e = os.path.splitext(file_name_no_path)
    if e.upper() in IMG_SUFFIX_FILTER:
        return True, IMG_FILE_TYPE
    elif e.upper() in VID_SUFFIX_FILTER:
        return True, VID_FILE_TYPE
    elif e.upper() in AUD_SUFFIX_FILTER:
        return True, AUD_FILE_TYPE
    else:
        return False, ""


def is_same_file_name(file_name, new_file_name):
    ret_val = False

    ext_len = 4
    if len(new_file_name) <= ext_len:
        return False

    name_len = len(new_file_name) - ext_len
    if file_name[:name_len] == new_file_name[:name_len] and file_name[-ext_len:] == new_file_name[-ext_len:]:
        ret_val = True

    return ret_val


def generate_new_file_name(file_name):
    # 根据照片的拍照时间生成新的文件名。如果获取不到拍照时间，则直接跳过
    try:
        if os.path.isfile(file_name):
            fd = open(file_name, 'rb')
        else:
            raise "[%s] is not a file!\n" % file_name
    except:
        raise "unopen file[%s]\n" % file_name

    # Default value
    ret_val = False
    new_file_name = ""
    def_suffix = "_00"

    # 原文件信息
    abs_path_file = os.path.abspath(file_name)
    dirname = os.path.dirname(abs_path_file)
    file_name_no_path = os.path.basename(abs_path_file)
    f, e = os.path.splitext(file_name_no_path)

    # Check if the file can be handled or not
    is_supported, file_type = is_target_file_type(file_name)
    if is_supported == False:
        return ret_val, new_file_name

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
                new_file_name = os.path.join(date_str + def_suffix + e).upper()
                ret_val = True
            except:
                pass
    elif file_type == VID_FILE_TYPE and g_handle_vedio == True:
        exiftool_cmd = "exiftool " + file_name
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
                        new_file_name = os.path.join(date_str + def_suffix + e).upper()
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
                            new_file_name = os.path.join(date_str + def_suffix + e).upper()
                            ret_val = True
                            break
                        else:
                            utc_date_time = datetime.strptime(modificationDateTime, '%Y:%m:%d %H:%M:%S')
                            utc_date_time = utc_date_time.replace(tzinfo=src_zone)
                            local_date_time = utc_date_time.astimezone(dst_zone)
                            date_str = local_date_time.strftime(my_data_format)
                            new_file_name = os.path.join(date_str + def_suffix + e).upper()
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
                            new_file_name = os.path.join(date_str + def_suffix + e).upper()
                            ret_val = True
                            break
                        else:
                            utc_date_time = datetime.strptime(creation_date_time, '%Y:%m:%d %H:%M:%S')
                            utc_date_time = utc_date_time.replace(tzinfo=src_zone)
                            local_date_time = utc_date_time.astimezone(dst_zone)
                            date_str = local_date_time.strftime(my_data_format)
                            new_file_name = os.path.join(date_str + def_suffix + e).upper()
                            ret_val = True
                            break
                    except:
                        ret_val = False
                        break
    elif file_type == AUD_FILE_TYPE and g_handle_audio == True:
        exiftool_cmd = "exiftool " + file_name
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
                            new_file_name = os.path.join(date_str + def_suffix + e).upper()
                            ret_val = True
                            break
                        else:
                            utc_date_time = datetime.strptime(creation_date_time, '%Y:%m:%d %H:%M:%S')
                            utc_date_time = utc_date_time.replace(tzinfo=src_zone)
                            local_date_time = utc_date_time.astimezone(dst_zone)
                            date_str = local_date_time.strftime(my_data_format)
                            new_file_name = os.path.join(date_str + def_suffix + e).upper()
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
                            new_file_name = os.path.join(date_str + def_suffix + e).upper()
                            ret_val = True
                            break
                        else:
                            utc_date_time = datetime.strptime(creation_date_time, '%Y:%m:%d %H:%M:%S')
                            utc_date_time = utc_date_time.replace(tzinfo=src_zone)
                            local_date_time = utc_date_time.astimezone(dst_zone)
                            date_str = local_date_time.strftime(my_data_format)
                            new_file_name = os.path.join(date_str + def_suffix + e).upper()
                            ret_val = True
                            break
                    except:
                        ret_val = False
                        break

    # 如果获取Exif信息失败，则采用该照片的创建日期重命名文件
    if ret_val == False and g_use_modified_date == True:
        state = os.stat(file_name)
        date_str = time.strftime(my_data_format, time.localtime(state[-2]))
        new_file_name = os.path.join(date_str + e).upper()
        ret_val = True

    # 检查新文件名是否合法
    if ret_val == True:
        # 如果新文件名与原文件名相同，则无需改名
        if is_same_file_name(file_name, new_file_name):
            ret_val = False
        # 如果新文件名与其他文件重名，则在新文件明后加后缀 _01, _02, .., _99
        elif new_file_name in os.listdir(dirname):
            for i in range(1, 100):
                tmpDateStr = date_str + "_" + str(i).zfill(2)
                new_file_name = os.path.join(tmpDateStr + e).upper()
                if is_same_file_name(file_name, new_file_name):
                    ret_val = False
                    break
                elif new_file_name not in os.listdir(dirname):
                    ret_val = True
                    break
        else:
            ret_val = True

    return ret_val, new_file_name


def scan_dir(startdir):
    # 只检查指定的一个文件
    if g_single_file != "":
        if os.path.isfile(g_single_file):
            obj = g_single_file
            # 对满足过滤条件的文件进行改名处理
            ret_val, new_file_name = generate_new_file_name(obj)
            if ret_val:
                try:
                    if g_is_execute == True:
                        os.rename(obj, new_file_name)
                    if g_use_abs_path == True:
                        print(os.path.abspath(obj), "\t=>\t", new_file_name)
                    else:
                        print(obj, "\t=>\t", new_file_name)
                except:
                    if g_is_quiet == False:
                        if g_use_abs_path == True:
                            print(os.path.abspath(obj), "\t=>\tcannot rename to ", new_file_name)
                        else:
                            print(obj, "\t=>\tcannot rename to ", new_file_name)
            else:
                if g_is_quiet == False:
                    if g_use_abs_path == True:
                        print(os.path.abspath(obj), "\t=>\tNo change")
                    else:
                        print(obj, "\t=>\tNo change")
        else:
            print(obj, " is not a vaild file!")
        return

    # 遍历指定目录以及子目录，对满足条件的文件进行改名
    os.chdir(startdir)
    for obj in os.listdir(os.curdir):
        if os.path.isfile(obj):
            # 对满足过滤条件的文件进行改名处理
            ret_val, new_file_name = generate_new_file_name(obj)
            if ret_val:
                try:
                    if g_is_execute == True:
                        os.rename(obj, new_file_name)
                    if g_use_abs_path == True:
                        print(os.path.abspath(obj), "\t=>\t", new_file_name)
                    else:
                        print(obj, "\t=>\t", new_file_name)
                except:
                    if g_is_quiet == False:
                        if g_use_abs_path == True:
                            print(os.path.abspath(obj), "\t=>\tcannot rename to ", new_file_name)
                        else:
                            print(obj, "\t=>\tcannot rename to ", new_file_name)
            else:
                if g_is_quiet == False:
                    if g_use_abs_path == True:
                        print(os.path.abspath(obj), "\t=>\tNo change")
                    else:
                        print(obj, "\t=>\tNo change")
        elif os.path.isdir(obj) and g_is_recursive == True:
            scan_dir(obj)
            os.chdir(os.pardir)


if __name__ == "__main__":
    parse_arguments()
    scan_dir(g_path_list[0])
