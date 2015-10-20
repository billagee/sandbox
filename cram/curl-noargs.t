To launch:
* pip install cram
* cram curl-noargs.t

Summary:
* Runs curl with no args, and checks that:
- The expected message is printed
- The exit code is 2

  $ curl
  curl: try 'curl --help' or 'curl --manual' for more information
  [2]

