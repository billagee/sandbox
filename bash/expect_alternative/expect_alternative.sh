#!/bin/bash -eux

./program_that_takes_several_lines_of_input.py <<EOD
first line
one enter keypress later

two enter keypresses later
EOD
