#!/bin/bash -ex

# https://unix.stackexchange.com/questions/238809/match-zero-or-more-operator-in-shell-globbing

if [ ! -d python3.8 ] ; then
  mkdir python3.8
fi
if [ ! -d python3.10 ] ; then
  mkdir python3.10
fi

# Match one or more minor version digits with vanilla bash globbing
ls -lad python?.[0-9]*

shopt -s extglob

# Same, but with various extglob approaches
ls -lad python?.@(?|??)

ls -lad python?.+(?)

ls -lad python?.+([0-9])

# Unset extglob
shopt -u extglob
