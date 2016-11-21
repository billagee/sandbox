#!/bin/bash

PROJECT_NAME="deleteme"

# If you don't mind repeating commands, you can use this simple style
# to loop over the output of a command until it returns an empty string:
#
#while [[ $(dx find projects --name "$PROJECT_NAME") ]]; do
#    PROJECT_ID=$(dx find projects --brief --name "$PROJECT_NAME" | head -n 1)
#    echo "found project '$PROJECT_ID'"
#    dx rmproject "$PROJECT_ID" --yes
#done

# Otherwise, you can save multiline output to a var, and read it line
# by line like this:
OLD_PROJECT_IDS=$(dx find projects --brief --name "$PROJECT_NAME")
echo "'$OLD_PROJECT_IDS'"

if [[ ! -z $OLD_PROJECT_IDS ]] ; then
    while IFS= read -r proj_id ; do
        echo $proj_id
        dx rmproject $proj_id --yes
    done <<< "$OLD_PROJECT_IDS"
fi
