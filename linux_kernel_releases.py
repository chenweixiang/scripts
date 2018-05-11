#! /usr/bin/python3

import os
import datetime
import subprocess
import argparse

'''
This script is executed in linux kernel repo and collects specified tags of linux
kernel repo, then it uses Graphviz to draw a figure to show relationship between
branches and tags. For instance:

chenwx@chenwx ~/linux $ ~/scripts/linux_kernel_releases.py -l "v3.2 v3.16 v3.18 v4.1 v4.4 v4.9 v4.14" -s "v4.15 v4.16" -o ~/Downloads/
'''

# Parse arguments
parser = argparse.ArgumentParser()
parser.add_argument("-b", "--begintag", help="begin tag, such as \"v3.0\". Tag v2.6.12 by default")
parser.add_argument("-e", "--endtag", help="end tag, such as \"v4.16\". Latest tag by default")
parser.add_argument("-l", "--longterm", help="longterm branch, such as \"v3.2 v3.16 v3.18 v4.1 v4.4 v4.9 v4.14\". Empty by default")
parser.add_argument("-s", "--stable", help="stable branch, such as \"v4.15 v4.16\". Empty by default")
parser.add_argument("-o", "--outdir", help="output directory. Current directory by default")
args = parser.parse_args()

# start tag
if args.begintag:
    beginTag = args.begintag
else:
    beginTag = "v2.6.12"

# end tag
if args.endtag:
    endTag = args.endtag
else:
    endTag = "latest"

# longterm branch
if args.longterm:
    longtermBranch = args.longterm
else:
    longtermBranch = ""

# stable branch
if args.stable:
    stableBranch = args.stable
else:
    stableBranch = ""

# output directory
if args.outdir:
    outDir = os.path.dirname(args.outdir)
    outDir = os.path.abspath(outDir)
    if not os.path.isdir(outDir):
        outDir = os.getcwd()
else:
    outDir = os.getcwd()

# list all tags in kernel repo
cmdKernelAllTags = ["git tag -l v[0-9]* --sort=v:refname"]
proc = subprocess.Popen(cmdKernelAllTags, stdout=subprocess.PIPE, shell=True)
kernelAllTags, errs = proc.communicate()
kernelAllTags = bytes.decode(kernelAllTags).split("\n")
proc.terminate()

# remove unused tags
kernelNeedTags = []
for oneTag in kernelAllTags:
    if "-rc" in oneTag:     # remove tags of candidate releases, such as v3.2-rc1, v3.2-rc2, ...
        continue
    elif "-pre" in oneTag:  # remove tags of
        continue
    elif oneTag == '':           # remove empty elements in tag list
        continue
    else:
        kernelNeedTags.append(oneTag)

# check the location of start tag and end tag
beginTagIdx = kernelNeedTags.index(beginTag)
if beginTagIdx >= 0:
    kernelNeedTags = kernelNeedTags[beginTagIdx:]
if endTag == "latest":
    endTag = kernelNeedTags[-1]
else:
    endTagIdx = kernelNeedTags.index(endTag)
    if endTagIdx >= 0:
        kernelNeedTags = kernelNeedTags[:endTagIdx]
    else:
        endTag = kernelNeedTags[-1]
#print(kernelNeedTags)

# show important parameters
print("Begin tag        :", beginTag)
print("End tag          :", endTag)
print("Longterm branch  :", longtermBranch)
print("Stable branch    :", stableBranch)
print("Output directory :", outDir)

# tags without keywork "-rc"
kernelNeedTagsList = []
kernelNeedTagsDict = {}
cnt = 0
for oneTag in kernelNeedTags:
    # strip the new line character in the end
    tag = oneTag.strip('\n')
    # add all tags to a list for reference
    kernelNeedTagsList.append(tag)
    # author of the tag
    cmdTagAuthor = ["git log -1 --date=short --pretty=format:'%an' " + tag]
    proc = subprocess.Popen(cmdTagAuthor, stdout=subprocess.PIPE, shell=True)
    tagAuthor, errs = proc.communicate()
    tagAuthor = bytes.decode(tagAuthor).split("\n")
    proc.terminate()
    # date of the tag
    cmdTagDate = ["git log -1 --date=short --pretty=format:'%ad' " + tag]
    proc = subprocess.Popen(cmdTagDate, stdout=subprocess.PIPE, shell=True)
    tagDate, errs = proc.communicate()
    tagDate = bytes.decode(tagDate).split("\n")
    # check the base tag (baseTag) of current tag (oneTag), and type of the branch (longterm or stable branch) this tag belongs to
    if cnt == 0:
        # branch type
        if oneTag in longtermBranch.split(" "):
            branchType = "longterm"
        elif oneTag in stableBranch.split(" "):
            branchType = "stable"
        else:
            branchType = ""
        # base tag
        baseTag = "NULL"
        baseBranchTag = oneTag.replace(".", "_")
    else:
        if "v2." in oneTag:     # for v2.6.12, v2.6.13, etc. there are two points in them
            if oneTag.count(".") == 2:
                # branch type
                if oneTag in longtermBranch.split(" "):
                    branchType = "longterm"
                elif oneTag in stableBranch.split(" "):
                    branchType = "stable"
                else:
                    branchType = ""
                # base tag
                baseTag = baseBranchTag.replace(".", "_")
                baseBranchTag = oneTag.replace(".", "_")
            else:
                baseTag = lastTag.replace(".", "_")
        else:                   # for v3.0, v4.2, etc. there are one points in them
            if oneTag.count(".") == 1:
                # branch type
                if oneTag in longtermBranch.split(" "):
                    branchType = "longterm"
                elif oneTag in stableBranch.split(" "):
                    branchType = "stable"
                else:
                    branchType = ""
                # base tag
                baseTag = baseBranchTag.replace(".", "_")
                baseBranchTag = oneTag.replace(".", "_")
            else:
                baseTag = lastTag.replace(".", "_")
    lastTag = oneTag
    # construct dictionary
    kernelNeedTagsDict[tag] = [tagAuthor[0], tagDate[0], baseTag, branchType]
    # count increase one
    cnt = cnt + 1

#print(kernelNeedTagsList)
#print(kernelNeedTagsDict)

# construct Graphviz configuration file
configFileName = outDir + "/Linux_Kernel_Release_" + datetime.date.today().strftime("%Y%m%d") + ".gv"
f = open(configFileName, "w")
f.write("digraph linux_kernel_tags\n")
f.write("{\n")
for oneTag in kernelNeedTagsList:
    # construct tag nodes
    nodeName = oneTag.replace(".", "_")
    # refer to http://www.graphviz.org/doc/info/colors.html#svg for color name
    if kernelNeedTagsDict[oneTag][3] == "longterm":
        filledColor = "style=filled, fillcolor=\"yellow\""
    elif kernelNeedTagsDict[oneTag][3] == "stable":
        filledColor = "style=filled, fillcolor=\"lightgreen\""
    else:
        filledColor = ""
    nodeAttribute = "    " + nodeName + " [shape=rectangle, label=\"" + oneTag + "\\n" + kernelNeedTagsDict[oneTag][1] + "\"" + filledColor + "];\n"
    f.write(nodeAttribute)
    # construct arrows
    arrowAttribute = "    " + kernelNeedTagsDict[oneTag][2] + " -> " + nodeName + " [arrowType=\"open\"]\n"
    if kernelNeedTagsDict[oneTag][2] != "NULL":
        f.write(arrowAttribute)
f.write("}\n")
f.close()

# generate PNG figure
cmdGraphviz = "dot -Tsvg -O " + configFileName
os.system(cmdGraphviz)
