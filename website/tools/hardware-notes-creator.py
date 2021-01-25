# -*- coding: utf-8 -*-
"""
BSD 2-Clause License

Copyright (c) 2020-2021, The FreeBSD Project
Copyright (c) 2020-2021, Sergio Carlavilla <carlavilla@FreeBSD.org>

This script will generate the Table of Contents of the Handbook
"""
#!/usr/bin/env python3

import sys, getopt
import ntpath
import subprocess
import os

manPagesPath = ""

def loadManPages(manPagesDir):
  manPagesPaths = []

  for root, _, files in os.walk(manPagesDir):
    for file in files:
      if file.endswith(".4"):
        manPagesPaths.append(os.path.join(root, file))
  return manPagesPaths

def createHardwareNotesDirectory(path):
  try:
    os.mkdir(path)
  except OSError:
    print ("Creation of the directory %s failed" % path)
  else:
    print ("Successfully created the directory %s " % path)

def main(argv):

  try:
    opts, args = getopt.getopt(argv,"hp:",["path="])
  except getopt.GetoptError:
    print('hardware-notes-creator.py -p <path>')
    sys.exit(2)

  for opt, arg in opts:
    if opt == '-h':
      print('hardware-notes-creator.py -p <path>')
      sys.exit()
    elif opt in ("-p", "--path"):
      manPagesPath = arg

  manPages = loadManPages("/home/carlavilla/Projects/base/src/share/man/man4/")
  createHardwareNotesDirectory('/home/carlavilla/Projects/testsssss')

  for manPage in manPages:
    manPageParsed = subprocess.getoutput("mandoc -Tmarkdown " + manPage + " | sed -n '/# HARDWARE/,/#/{/#/!p;}'")

    if len(manPageParsed) > 0:
      manPageName = ntpath.basename(manPage).replace(".4", "")

      with open('/home/carlavilla/Projects/testsssss/{}.adoc'.format(manPageName), 'w', encoding = 'utf-8') as manPageFile:
        manPageFile.write(manPageParsed)

if __name__ == "__main__":
  main(sys.argv[1:])
