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
g_path_list = []

g_file_list = []
g_file_md5sum_list = defaultdict(list)


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

    if g_is_verbose:
        print('\n')
        print("g_path_list:")
        for path in g_path_list:
            print(path)


def scan_path(start_path):
    global g_file_list
    global g_is_recursive
    global g_is_verbose

    curr_path = Path(start_path)
    curr_path_str = curr_path.resolve()

    if g_is_verbose == True:
        print('\n')
        print("curr_path_str:")
        print(curr_path_str)

    sub_dir_list = []

    for item in curr_path.iterdir():
        if item.is_file() and not str(item.name).startswith('.'):
            g_file_list.append(curr_path_str / item)
        elif item.is_dir() and g_is_recursive and not str(item.name).startswith('.'):
            sub_dir_list.append(curr_path_str / item)

    if g_is_verbose == True:
        print('\n')
        print("g_file_list:")
        for file in g_file_list:
            print(file)

    if g_is_recursive == True:
        if g_is_verbose == True:
            print('\n')
            print("sub_dir_list:")
            if len(sub_dir_list) > 0:
                for sub_dir in sub_dir_list:
                    print(sub_dir)
            else:
                print("Empty!")

        for dir in sub_dir_list:
            scan_path(dir)


def calc_md5sum():
    global g_file_list
    global g_is_verbose
    global g_show_single_file

    if g_is_verbose:
        print('\n')
        print("md5sum per file:")

    for file in g_file_list:
        with open(file, 'rb') as fp:
            data = fp.read()
            file_md5 = hashlib.md5(data).hexdigest()
            g_file_md5sum_list[file_md5].append(file)

            if g_is_verbose:
                print(file_md5, file)

    print('\n')
    print("Duplicated files")
    print('\n')

    for md5sum in g_file_md5sum_list:
        if len(g_file_md5sum_list[md5sum]) > 1:
            print(md5sum)
            for file in g_file_md5sum_list[md5sum]:
                print(file)
            print('\n')

    if g_show_single_file == True:
        print("Not duplicated files")
        print('\n')

        for md5sum in g_file_md5sum_list:
            if len(g_file_md5sum_list[md5sum]) == 1:
                print(md5sum)
                for file in g_file_md5sum_list[md5sum]:
                    print(file)
                print('\n')

if __name__ == "__main__":
    parse_arguments()

    for path in g_path_list:
        scan_path(path)

    calc_md5sum()
