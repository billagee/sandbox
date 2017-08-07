#!/bin/bash -e

theuser="jenkins"

if id -u $theuser ; then
    echo "User exists"
else
    echo "User doesn't exist"
fi
