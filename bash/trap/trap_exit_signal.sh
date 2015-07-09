#!/bin/bash
set -e -x

# In bash this should always run at exit
function finish {
    echo >&2 "
***********************************
***  TRAP - EXIT STATUS IS \"$1\"  ***
***********************************
"
    echo "In finish function..." >&2
    # Cleanup work goes here
    exit "$1"
}

trap 'finish $?' EXIT

#true
false

