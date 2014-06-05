#!/bin/bash
#set -x

echo "When you grep a header from curl output, it'll include a trailing \r."
echo "You can see the trailing 0d in the hexdump of the string:"
echo ""
header=$(curl -s --head http://www.google.com | grep Content-Type:)
printf "$header" | xxd -

echo ""
echo "To create a string literal to compare to the above header, you can pass"
echo "a string to printf and include a literal \r:"
echo ""
expected_header=$(printf 'Content-Type: text/html; charset=ISO-8859-1\r')
printf "$expected_header" | xxd -

if [ ! "$header" = "$expected_header" ] ; then
  echo "Incorrect header: '$header'"
  exit 1
fi

exit 0

