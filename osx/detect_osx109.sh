#!/bin/bash

# Will be 1 if running 10.9, 0 otherwise
IS_OSX_109=`sw_vers -productVersion | grep -cm1 10.9`

if [[ $IS_OSX_109 -eq 1 ]] ; then
    echo "Is 10.9"
else
    echo "Not 10.9"
fi

