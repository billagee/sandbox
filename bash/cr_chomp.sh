#!/bin/bash
#set -x

if [ -z "$1" ] ; then
  echo "No hostname given; example usage:"
  echo "$0 www.example.com"
  exit 1
fi

# Trims trailing \r from first arg. Example invocation:
#   chomped_foo=$(cr_chomp "$foo")
cr_chomp() {
  local chomped=${1%$'\r'}
  echo "$chomped"
}

# Demo function that utilizes cr_chomp function
#
# $1 is an HTTP header field name to inspect
# $2 is the complete header string you expect
# Example invocation:
#   retrieve_and_check_header "Content-Type:" "text/html"
retrieve_and_check_header () {
  header_name=$1
  actual_header=$(curl -s --head "$BASE_URL" | grep "$header_name")
  chomped_header=$(cr_chomp "$actual_header")
  echo "Actual header:"
  printf "$actual_header" | xxd -
  echo "Chomped header:"
  printf "$chomped_header" | xxd -

  expected_header_value=$2
  expected_header_full="$1 $2"
  if [ ! "$chomped_header" = "$expected_header_full" ] ; then
    echo "Incorrect $header_name header value from server".
    echo "Expected '$expected_header_full' but got '$chomped_header'"
    exit 1
  fi
}

BASE_URL="http://$1"

retrieve_and_check_header "Content-Type:" "text/html"

# Negative case:
#retrieve_and_check_header "Content-Type:" "text/htmlZZZ"

exit 0

