#!/bin/bash
set -e -x

function finish {
    echo >&2 "
***********************************
***  TRAP - EXIT STATUS IS \"$1\"  ***
***********************************
"
    echo "In finish function...pending exit status should be 99." >&2

    # ...then when something else goes wrong here, -e would make us exit
    # with new error status instead of the original code (in $1), unless
    # we `set +e` like so:
    set +e
    false
    #set -e

    # Note this would never be reached without that `set +e`:
    echo "All done with cleanup, exiting..." >&2
    exit "$1"
}

trap 'finish $?' EXIT

#true
#false
exit 99

