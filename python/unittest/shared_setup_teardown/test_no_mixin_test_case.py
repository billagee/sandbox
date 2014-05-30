from base_test_case import BaseTestCase

class NoMixinTestCase(BaseTestCase):
    def test_bar(self):
        #.. etc ..
        print("In NoMixinTestCase#test_bar")
        self.do_something()
