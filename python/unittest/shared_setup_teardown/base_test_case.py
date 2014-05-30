# Run with 'pytest -s'
#
# See also:
# http://nedbatchelder.com/blog/201210/multiple_inheritance_is_hard.html
# http://www.ianlewis.org/en/mixins-and-python

import unittest

class BaseTestCase(unittest.TestCase):
    def setUp(self):
        super(BaseTestCase, self).setUp()
        #.. set up that everyone needs ..
        print("In BaseTestCase#setUp")

    def tearDown(self):
        #.. tear down that everyone needs ..
        super(BaseTestCase, self).tearDown()
        print("In BaseTestCase#tearDown")

    def do_something(self):
        print("In BaseTestCase#do_something")

