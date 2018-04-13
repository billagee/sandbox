#!/usr/bin/env python

# Log a test ID (different from the test name) and its result at the
# end of each test.
# Based on https://stackoverflow.com/a/34323254
#
# Should work with either py.test or the unittest runner:
#  * py.test test_log_test_result_at_teardown.py -s
#  * ./test_log_test_result_at_teardown.py

import functools
import pytest
import sys
import unittest

class TestFoo(unittest.TestCase):
    def print_test_case_ids(id_array):
        def decorator(func):
            print("Entering decorator")
            @functools.wraps(func)
            def wrapper(*args, **kwargs):
                print("Entering wrapper")
                try:
                    retval = func(*args, **kwargs)
                    for tid in id_array:
                        print("{}\t{}".format(tid, "PASSED"))
                    print("Leaving wrapper")
                except Exception as e:
                    for tid in id_array:
                        print("{}\t{}".format(tid, "FAILED"))
                    print("Leaving wrapper")
                    # NOTE: In Python 3, sounds like we can use 'raise e' to
                    # take care of preserving exception data when re-raising?
                    # https://stackoverflow.com/a/18188660
                    t, v, tb = sys.exc_info()
                    raise t, v, tb
            return wrapper
            print("Leaving decorator")
        return decorator

    @pytest.mark.USE_THIS_TAG_TO_SELECT_TEST_WITH_PYTEST
    @print_test_case_ids(["FOO_0001", "FOO_0002"])
    def test_foo_passes(self):
        print("Entering test_foo_passes")
        self.assertEqual('foo'.upper(), 'FOO')
        print("Leaving test_foo_passes")

    @pytest.mark.USE_THIS_TAG_TO_SELECT_TEST_WITH_PYTEST
    @print_test_case_ids(["FOO_9999"])
    def test_foo_fails(self):
        print("Entering test_foo_fails")
        self.assertEqual(1, 2)
        print("Leaving test_foo_fails")

    # Test with no decorators
    def test_bar(self):
        print("Entering test_bar")
        self.assertEqual('foo'.upper(), 'FOO')
        print("Leaving test_bar")

if __name__ == '__main__':
    unittest.main()
