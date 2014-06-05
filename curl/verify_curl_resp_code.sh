#!/bin/bash
set -x

expected_resp_code="200"
echo "Making sure the response code is '$expected_resp_code'..."
actual_resp_code=$(curl --silent --head --write-out %{http_code} http://www.google.com -o /dev/null)

if [ ! "$actual_resp_code" = "$expected_resp_code" ] ; then
  echo "Expected '$expected_resp_code', but got resp code '$actual_resp_code'"
  exit 1
fi

exit 0

