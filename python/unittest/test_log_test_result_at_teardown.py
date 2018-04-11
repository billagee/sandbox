#!/usr/bin/env python

# Log a test ID and its result at teardown

import functools
import pytest
import unittest

class TestFoo(unittest.TestCase):
    def catch_exception(func):
        @functools.wraps(func)
        def wrapper(*args, **kwargs):
            print("hi")
        return wrapper

    @pytest.mark.foo
    @catch_exception
    def test_foo(self):
        self.assertEqual('foo'.upper(), 'FOO')

if __name__ == '__main__':
    unittest.main()
