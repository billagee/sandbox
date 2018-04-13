#!/usr/bin/env python

# This test defines a unittest case, but with pytest decorators applied.
# It should be possible to run this test with either the unittest runner
# or the pytest runner:
#
# * ./test_pass_with_pytest_decorators.py
# * py.test test_pass_with_pytest_decorators.py

import pytest
import unittest

class TestFoo(unittest.TestCase):
    @pytest.mark.foo
    def test_foo(self):
        self.assertEqual('foo'.upper(), 'FOO')

if __name__ == '__main__':
    unittest.main()
