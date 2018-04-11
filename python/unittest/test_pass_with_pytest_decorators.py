#!/usr/bin/env python

# This test defines a unittest case, but with pytest decorators applied.

import pytest
import unittest

class TestFoo(unittest.TestCase):
    @pytest.mark.foo
    def test_foo(self):
        self.assertEqual('foo'.upper(), 'FOO')

if __name__ == '__main__':
    unittest.main()
