from base_test_case import BaseTestCase
from my_mixin import MyMixin

#class RealTestCase(BaseTestCase, MyMixin):
class RealTestCase(MyMixin, BaseTestCase):
    # I didn't need setUp and tearDown here..

    def test_foo(self):
        #.. etc ..
        print("In RealTestCase#test_foo")
        self.do_something()

