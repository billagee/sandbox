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

class MyMixin(object):
    def setUp(self):
        super(MyMixin, self).setUp()
        #.. do something here ..
        print("In MyMixin#setUp")

    def tearDown(self):
        #.. do something here ..
        super(MyMixin, self).tearDown()
        print("In MyMixin#tearDown")

    def doit(self):
        print("In MyMixin#doit")

#class RealTestCase(BaseTestCase, MyMixin):
class RealTestCase(MyMixin, BaseTestCase):
    # I didn't need setUp and tearDown here..

    def test_foo(self):
        #.. etc ..
        print("In RealTestCase#test_foo")
        self.doit()

class NoMixinTestCase(BaseTestCase):
    def test_bar(self):
        #.. etc ..
        print("In NoMixinTestCase#test_bar")
