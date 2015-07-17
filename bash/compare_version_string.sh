#!/bin/bash
#set -x

#R_VERSION_EXPECTED="R version 3.0.3 (2014-03-06) -- \"Warm Puppy\""
R_VERSION_EXPECTED="R version 3.2.0 (2015-04-16) -- \"Full of Ingredients\""
R_VERSION=$(R --version | egrep "R version")
#printf "$R_VERSION" | xxd -

if [[ ! "$R_VERSION" = "$R_VERSION_EXPECTED" ]] ; then
  echo "Expected '$R_VERSION_EXPECTED', but found '$R_VERSION'"
  exit 1
fi

exit 0

