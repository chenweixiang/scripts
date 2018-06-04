#! /usr/bin/python3

import os
import datetime
import subprocess
import argparse

'''
This script is executed in linux kernel repo and collects specified tags of linux
kernel repo, then it uses Graphviz to draw a figure to show relationship between
branches and tags. The branch type information can be got from kernel official site
https://www.kernel.org/. For instance:

chenwx@chenwx ~/linux $ ~/scripts/linux_kernel_releases.py -l "v3.2 v3.16 v3.18 v4.1 v4.4 v4.9 v4.14" -s "v4.16" -m "v4.17" -o ~/Downloads/
'''

# Parse arguments
parser = argparse.ArgumentParser()
parser.add_argument("-b", "--begintag", help="begin tag, such as \"v3.0\". Tag v2.6.12 by default")
parser.add_argument("-e", "--endtag", help="end tag, such as \"v4.16\". Latest tag by default")
parser.add_argument("-l", "--longterm", help="longterm branch, such as \"v3.2 v3.16 v3.18 v4.1 v4.4 v4.9 v4.14\". Empty by default")
parser.add_argument("-s", "--stable", help="stable branch, such as \"v4.15\". Empty by default")
parser.add_argument("-m", "--mainline", help="mainline branch, such as \"v4.16\". Empty by default")
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

# mainline branch
if args.mainline:
    mainlineBranch = args.mainline
else:
    mainlineBranch = ""

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
    elif oneTag == '':      # remove empty elements in tag list
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
print("Mainline branch  :", mainlineBranch)
print("Output directory :", outDir)

# tags without keywork "-rc", "-pre1"
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
        if tag in longtermBranch.split(" "):
            branchType = "longterm"
        elif tag in stableBranch.split(" "):
            branchType = "stable"
        elif tag in mainlineBranch.split(" "):
            branchType = "mainline"
        else:
            branchType = ""
        # base tag
        baseTag = "NULL"
        baseBranchTag = oneTag.replace(".", "_")
        branchName = "linux-" + tag[1:] + ".y"  # for instance, linux-3.2.y
    else:
        if "v2." in tag:     # for v2.6.12, v2.6.13, etc. there are two dots in them
            if oneTag.count(".") == 2:
                # branch type
                if tag in longtermBranch.split(" "):
                    branchType = "longterm"
                elif tag in stableBranch.split(" "):
                    branchType = "stable"
                elif tag in mainlineBranch.split(" "):
                    branchType = "mainline"
                else:
                    branchType = ""
                # base tag
                baseTag = baseBranchTag.replace(".", "_")
                baseBranchTag = tag.replace(".", "_")
                branchName = "linux-" + tag[1:] + ".y"  # for instance, linux-3.2.y
            else:
                baseTag = lastTag.replace(".", "_")
                branchName = "NULL"
        else:                   # for v3.0, v4.2, etc. there are one dot in them
            if tag.count(".") == 1:
                # branch type
                if tag in longtermBranch.split(" "):
                    branchType = "longterm"
                elif tag in stableBranch.split(" "):
                    branchType = "stable"
                elif tag in mainlineBranch.split(" "):
                    branchType = "mainline"
                else:
                    branchType = ""
                # base tag
                baseTag = baseBranchTag.replace(".", "_")
                baseBranchTag = tag.replace(".", "_")
                branchName = "linux-" + tag[1:] + ".y"  # for instance, linux-3.2.y
            else:
                baseTag = lastTag.replace(".", "_")
                branchName = "NULL"
    lastTag = tag
    # construct dictionary
    kernelNeedTagsDict[tag] = [tagAuthor[0], tagDate[0], baseTag, branchType, branchName]
    # count increase one
    cnt = cnt + 1

#for tag in kernelNeedTagsList:
#    print(tag, ":", kernelNeedTagsDict[tag])

# construct Graphviz configuration file
configFileName = outDir + "/Linux_Kernel_Releases_" + datetime.date.today().strftime("%Y%m%d") + ".gv"
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
    elif kernelNeedTagsDict[oneTag][3] == "mainline":
        filledColor = "style=filled, fillcolor=\"green\""
    else:
        filledColor = "style=filled, fillcolor=\"white\""
    # construct node with branch name
    if kernelNeedTagsDict[oneTag][4] != "NULL":
        branchNodeName = kernelNeedTagsDict[oneTag][4].replace("-", "_")
        branchNodeName = branchNodeName.replace(".", "_")
        branchNodeAttribute = "    " + branchNodeName + " [shape=rectangle, label=\"" + kernelNeedTagsDict[oneTag][4] + "\", " + filledColor + "];\n"
        f.write(branchNodeAttribute)
    # contruct node with tag
    nodeAttribute = "    " + nodeName + " [shape=rectangle, label=\"" + oneTag + "\\n" + kernelNeedTagsDict[oneTag][1] + "\", " + filledColor + "];\n"
    f.write(nodeAttribute)
    # construct arrows
    if kernelNeedTagsDict[oneTag][4] != "NULL":
        arrowBranchAttribute = "    " + branchNodeName + " -> " + nodeName + " [style=dashed]\n"
        f.write(arrowBranchAttribute)
    if kernelNeedTagsDict[oneTag][2] != "NULL":
        arrowAttribute = "    " + kernelNeedTagsDict[oneTag][2] + " -> " + nodeName + " [arrowType=\"open\"]\n"
        f.write(arrowAttribute)

f.write("}\n")
f.close()

# generate PNG figure
outputFileName = configFileName.strip(".gv") + ".svg"
cmdGraphviz = "dot -Tsvg " + configFileName + " -o " + outputFileName
os.system(cmdGraphviz)
