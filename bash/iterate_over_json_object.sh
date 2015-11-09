#!/bin/bash
#
# Illustrates how to use jq from a bash script to iterate over
# the keys in a JSON object.

set -e

# Write a JSON file to disk that contains values to read later:
JSON_FILENAME=foo-data.json

cat << JSON_EOF > $JSON_FILENAME
{
  "foo": {
    "a_string": "foostring",
    "an_int": 1,
    "optional_value": 2000000
  },
  "bar": {
    "a_string": "barstring",
    "an_int": 2,
    "optional_value": null
  },
  "baz": {
    "a_string": "bazstring",
    "an_int": 3
  }
}
JSON_EOF

echo "jq version is $(jq --version)"

# $1 is a jq filter to apply to $JSON_FILENAME. Output will be
# raw text with no quotes introduced by JSON formatting.
function rawfilter() {
    echo $(jq --raw-output $1 ${JSON_FILENAME})
}

# Read all the JSON object's keys into a bash array
an_array=( $(rawfilter 'keys[]' ${JSON_FILENAME}) )

#printf "%s\n" ${an_array[@]}  # print keys
#echo $(jq . ${JSON_FILENAME}) # print entire object

# Use the JSON values to build a command string to eval, then store
# the output of each command in an array:
OUTPUT_ARRAY=()

for the_key in ${an_array[@]}; do
    # Assign applet input vars using JSON data
    a_string=$(rawfilter .$the_key.a_string)
    an_int=$(rawfilter .$the_key.an_int)
    optval=$(rawfilter .$the_key.optional_value)

    #echo "Building command string for $the_key..."
    cmd_to_run="echo the_key: $the_key ... a_string: $a_string ... an_int: $an_int"

    if [ $optval != "null" ] ; then
        cmd_to_run="${cmd_to_run} ... optional_value: ${optval}"
    fi

    # Execute command
    cmd_output=$(eval "${cmd_to_run}")
    #echo "cmd_output is: '${cmd_output}'"

    # Save output
    # NOTE - without quoting $cmd_output below, you'll end up appending many
    # array elements, since the string will be split on whitespace:
    OUTPUT_ARRAY+=("$cmd_output")
done

echo "Output array len: ${#OUTPUT_ARRAY[@]}"

# Print entire array contents using printf
#printf '%s\n' "${OUTPUT_ARRAY[@]}"

# Or using for, resetting IFS to prevent the loop from splitting on the
# whitespace found in the elements:
: <<'END_COMMENT'
IFS=$'\n'
for i in ${OUTPUT_ARRAY[@]}; do
    echo "****"
    echo ${i}
done
unset IFS
END_COMMENT

# Using the array index prevents whitespace splitting:
for ((i = 0; i < ${#OUTPUT_ARRAY[@]}; i++)); do
    echo "**** command output string #$i was: ***"
    echo "${OUTPUT_ARRAY[i]}"
done

