#!/bin/sh

echo "**** This run invokes make without setting FOOVAR beforehand:"
make
echo "\n"
echo "**** This run invokes make with FOOVAR set to a value, which should then be available in the Makefile's reciples:"
FOOVAR=fromoutside make

