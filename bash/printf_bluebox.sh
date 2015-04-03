#!/bin/bash -e

# Prints a boxed message in blue, for example:
#
#  *************************
# *                         *
#*  This is a test message!  *
# *                         *
#  *************************

function printf_bluebox()
{
  local inputstring="$*"
  blue=`tput setaf 4`
  reset=`tput sgr0`

  BOXTEXT="  *${inputstring//?/*}*
 * ${inputstring//?/ } *
*  $inputstring  *
 * ${inputstring//?/ } *
  *${inputstring//?/*}*"

  # In Jenkins shell code you have to do this to get the same effect:
  #BOXTEXT="  *${inputstring//?/*}*\r * ${inputstring//?/ } *\r*  $inputstring  *\r * ${inputstring//?/ } *\r  *${inputstring//?/*}*\r"

  printf "${blue}${BOXTEXT}${reset}"
  printf '\n'
}

printf_bluebox "This is a test message!"

echo "Another line, this time from echo"

