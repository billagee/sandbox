Summary:
* Commands are expected to exit 0 unless otherwise specified; a failure
will be triggered if a command's exit status is non-zero.

* When you expect a non-zero exit status, it can be checked by placing [n]
below the command's output.

  $ true
  $ false
  [1]

Note that the exit status of a subshell bubbles up to the parent shell:

  $ (echo 'hi from a subshell!' && exit 99)
  hi from a subshell!
  [99]

This will cause a failure since the exit status 1 from false isn't handled:

  $ false

