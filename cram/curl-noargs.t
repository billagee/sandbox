Summary:

Run curl with no args, and check that:
- The resulting message is correct
- Its exit code is 2

Prereqs:

pip install cram

Usage:

cram curl-noargs.t

  $ curl
  curl: try 'curl --help' or 'curl --manual' for more information
  [2]

