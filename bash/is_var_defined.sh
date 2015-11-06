#!/bin/bash

if [ -z ${foo+x} ]; then
    echo "foo is not set."
fi

foo=VALUE_OF_FOO

if [ -z ${foo+x} ]; then
    echo "foo is not set."
else
    echo "foo is now set to '$foo'"
fi

unset foo

if [ -z ${foo+x} ]; then
    echo "foo is not set."
else
    echo "foo is now set to '$foo'"
fi

# Requires bash 4.2:
if [[ -v foo ]] ; then
    echo "foo is now set to '$foo'"
else
    echo "foo is not set."
fi

foo=VALUE_OF_FOO_REDUX

if [[ -v foo ]] ; then
    echo "foo is now set to '$foo'"
else
    echo "foo is not set."
fi

