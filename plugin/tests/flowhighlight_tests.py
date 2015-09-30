import unittest
import flowhighlight as sut


@unittest.skip("Don't forget to test!")
class FlowhighlightTests(unittest.TestCase):

    def test_example_fail(self):
        result = sut.flowhighlight_example()
        self.assertEqual("Happy Hacking", result)
