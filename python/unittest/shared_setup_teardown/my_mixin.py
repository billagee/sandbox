# Run with 'pytest -s'
#
# See also:
# http://nedbatchelder.com/blog/201210/multiple_inheritance_is_hard.html
# http://www.ianlewis.org/en/mixins-and-python

import unittest

class MyMixin(object):
    #def setUp(self):
    #    super(MyMixin, self).setUp()
    #    #.. do something here ..
    #    print("In MyMixin#setUp")

    #def tearDown(self):
    #    #.. do something here ..
    #    super(MyMixin, self).tearDown()
    #    print("In MyMixin#tearDown")

    def do_something(self):
        print("In MyMixin#do_something")

