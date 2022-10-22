#!/usr/bin/env python3
# -*- coding: utf-8 -*-

'''
Generate sha256sum of files in specified directory.
'''

import os
import argparse
import hashlib
from pathlib import Path


# SHA command
shaCommand  = "sha256sum"
shaOptions  = "-b"
cmdPrefix   = shaCommand + " " + shaOptions + " "

# File filter
fileFilter = [".DS_Store"]


def parseArguments():
    # Parse arguments
    parser = argparse.ArgumentParser(description='')
    parser.add_argument("-d", "--directory", help="Specify directory.")
    args = parser.parse_args()

    # -d, --directory
    path = "."
    if args.directory and Path(args.directory).exists():
        path = args.directory

    return path


def getFileList(path):
    # Get file list in path and its sub-directory
    fileList = list()
    for dirPath, dirNames, fileNames in os.walk(path, followlinks=True):
        for fileName in fileNames:
            if fileName not in fileFilter:
                filePath = os.path.join(dirPath, fileName)
                fileList.append(filePath)

    fileList.sort()
    return fileList


def calcFileSha256(fileName):
    with open(fileName, "rb") as f:
        sha256obj = hashlib.sha256()
        sha256obj.update(f.read())
        hashValue = sha256obj.hexdigest()
        return hashValue


def mainFunc():
    path = parseArguments()

    fileList = getFileList(path)
    print(len(fileList))
    #result = list()

    for f in fileList:
        hash = calcFileSha256(f)
        print(hash, f)


if __name__ == "__main__":
    mainFunc()

