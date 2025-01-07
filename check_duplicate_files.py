#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import argparse
import subprocess
import hashlib
from pathlib import Path
from collections import defaultdict


g_is_recursive = False
g_is_verbose = False
g_show_single_file = False


def parse_arguments():
    # Parse arguments
    parser = argparse.ArgumentParser(description='')
    parser.add_argument("-d", "--directory", help="Specify directory.")
    parser.add_argument("-r", "--recursive", action="store_true", help="Recursive all sub-directories.")
    parser.add_argument("-s", "--show_single_file", action="store_true", help="Show not duplicated files.")
    parser.add_argument("-v", "--verbose", action="store_true", help="Print debug traces")
    args = parser.parse_args()

    # -r, --recursive
    global g_is_recursive
    if args.recursive:
        g_is_recursive = True

    # -v, --verbose
    global g_is_verbose
    if args.verbose:
        g_is_verbose = True

    # -s, --show_single_file
    global g_show_single_file
    if args.show_single_file:
        g_show_single_file = True

    # -d, --directory
    path_list = []
    if args.directory:
        input_path_list = args.directory.split()
        for path in input_path_list:
            path_obj = Path(path)
            if path_obj.exists():
                path_str = path_obj.resolve()
                if path_str not in path_list:
                    path_list.append(path_str)
    else:
        path_list.append(Path().absolute())

    return path_list


def scan_path(start_path):
    global g_is_recursive

    curr_path = Path(start_path)
    curr_path_str = curr_path.resolve()

    file_list = []
    sub_dir_list = []

    for item in curr_path.iterdir():
        if item.is_file() and not str(item.name).startswith('.'):
            file_list.append(curr_path_str / item)
        elif item.is_dir() and g_is_recursive and not str(item.name).startswith('.'):
            sub_dir_list.append(curr_path_str / item)

    if g_is_recursive == True:
        for dir in sub_dir_list:
            file_list_in_sub_dir = scan_path(dir)
            file_list.extend(file_list_in_sub_dir)

    return file_list


def calc_md5sum(file_list):
    global g_is_verbose
    global g_show_single_file

    md5sum_file_dict = defaultdict(list)

    if g_is_verbose:
        print('\n')
        print("md5sum per file:")

    for file in file_list:
        with open(file, 'rb') as fp:
            data = fp.read()
            md5sum = hashlib.md5(data).hexdigest()
            md5sum_file_dict[md5sum].append(file)

            if g_is_verbose:
                print(md5sum, file)

    return md5sum_file_dict


if __name__ == "__main__":
    path_list = parse_arguments()

    if g_is_verbose:
        print('\n')
        print("path_list:")
        for path in path_list:
            print(path)

    file_list = []

    for path in path_list:
        file_list_in_path = scan_path(path)
        file_list.extend(file_list_in_path)

    if g_is_verbose == True:
        print('\n')
        print("file_list:")
        for file in file_list:
            print(file)

    md5sum_file_dict = calc_md5sum(file_list)

    print('\n')
    print("Duplicated files:")
    print('\n')

    for md5sum in md5sum_file_dict:
        if len(md5sum_file_dict[md5sum]) > 1:
            print(md5sum)
            for file in md5sum_file_dict[md5sum]:
                print(file)
            print('\n')

    if g_show_single_file == True:
        print("Not duplicated files:")
        print('\n')

        for md5sum in md5sum_file_dict:
            if len(md5sum_file_dict[md5sum]) == 1:
                print(md5sum)
                for file in md5sum_file_dict[md5sum]:
                    print(file)
                print('\n')

