#!/usr/bin/env python

import argparse
import sys

parser = argparse.ArgumentParser()
parser.add_argument('--required_value', required=True)
args = parser.parse_args(sys.argv[1:])

print "Your value was: {0}".format(args.required_value)
