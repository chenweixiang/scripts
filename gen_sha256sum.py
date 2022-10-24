#!/usr/bin/env python3
# -*- coding: utf-8 -*-

'''
Generate sha256sum of files in specified directory and its sub-directories.

Generate sha256sum:
$ ~/scripts/gen_sha256sum.py -d <Directory> > <OutputFile>

Check sha256sum:
$ sha256sum --quiet -c <OutputFile>

Example:
~/scripts/gen_sha256sum.py -d Repository > Repository_sync_20221022
sha256sum --quiet -c Repository_sync_20221022
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
filePrefix = (".DS_Store", "._")


def parseArguments():
    # Parse arguments
    parser = argparse.ArgumentParser(description='')
    parser.add_argument("-d", "--directory", action='append', help="Specify directory.")
    args = parser.parse_args()

    # -d, --directory
    paths = []
    if args.directory:
        for path in args.directory:
            if Path(path).exists():
                paths.append(path)
    else:
        paths.append(".")

    return paths


def getFileList(paths):
    # Get file list in path and its sub-directory
    fileList = list()
    for path in paths:
        for dirPath, dirNames, fileNames in os.walk(path, followlinks=True):
            for fileName in fileNames:
                if not fileName.startswith(filePrefix):
                    filePath = os.path.join(dirPath, fileName)
                    if filePath not in fileList:
                        fileList.append(filePath)

    fileList.sort()
    return fileList


def calcFileSha256(fileName):
    with open(fileName, "rb") as f:
        sha256obj = hashlib.sha256()
        sha256obj.update(f.read())
        hashValue = sha256obj.hexdigest()
        return hashValue


def main():
    paths = parseArguments()

    fileList = getFileList(paths)
    #result = list()

    for f in fileList:
        hash = calcFileSha256(f)
        print(hash, f)


if __name__ == "__main__":
    main()

