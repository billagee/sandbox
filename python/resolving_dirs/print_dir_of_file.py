#!/usr/bin/env python

import os

print("This script will print the absolute path of the dir it lives in.\n")

print("Here's one way to do it:")
my_filedir = os.path.abspath(__file__ + "/../")
print my_filedir

print("And another:")
my_filedir = os.path.dirname(os.path.abspath(__file__))
print my_filedir
