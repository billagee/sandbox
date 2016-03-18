#!/bin/bash

# See http://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-stored-in
MYDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "I live in '${MYDIR}'"
