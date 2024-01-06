#!/usr/bin/env python3
# -*- coding: utf-8 -*-

'''
Find files or folders with absolute path.
'''


# Import libraries
import os
import argparse
from pathlib import Path


# Global Variables
g_path = "."
g_type = "f"
g_useAbsPath = True
g_string = ""

# Functions
def parseArguments():
    # Parse arguments
    parser = argparse.ArgumentParser(description='')
    parser.add_argument("-d", "--directory", help="Specify directory.")
    parser.add_argument("-r", "--relativepath", action="store_true", help="Use relative path.")
    parser.add_argument("-s", "--string", help="Search string.")
    parser.add_argument("-t", "--type", help="Type: f for file, d for directory.")
    args = parser.parse_args()

    # -d, --directory
    global g_path
    if args.directory and Path(args.directory).exists():
        g_path = args.directory

    # -r, --relativepath
    global g_useAbsPath
    if args.relativepath:
        g_useAbsPath = False

    # -s, --string
    global g_string
    if args.string:
        g_string = args.string

    # -t, --type
    global g_type
    if args.type:
        g_type = args.type

    #print("Path              :", os.path.abspath(g_path))
    #print("Use absolute path :", g_useAbsPath)
    #print("String            :", g_string)


def mainFunc():
    global g_path
    global g_useAbsPath
    global g_type
    global g_string
    findCmd = "find " + g_path + " -noignore_readdir_race -type " + g_type + " -iname " + g_string + " -exec readlink -f {} \;"
    #print(findCmd)
    os.system(findCmd)


# Main entry
if __name__ == "__main__":
    parseArguments()
    mainFunc()
