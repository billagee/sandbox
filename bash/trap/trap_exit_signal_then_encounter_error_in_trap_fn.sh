#!/bin/bash
set -e -x

function finish {
    echo >&2 "
***********************************
***  TRAP - EXIT STATUS IS \"$1\"  ***
***********************************
"
    echo "In finish function...pending exit status should be 99." >&2

    # ...then when something else goes wrong here, -e makes us exit
    # with the new error status instead of the original one (in $1):
    false

    # Note this will never be reached:
    echo "All done with cleanup, exiting..." >&2
    exit "$1"
}

trap 'finish $?' EXIT

#true
#false
exit 99

