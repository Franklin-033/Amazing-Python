import unittest
from App.main import add

class TestAddFunction(unittest.TestCase):
    def test_add(self):
        self.assertEqual(add(2, 3), 5)

#if name == '__main__':
if __name__ == '__main__':  
    unittest.main()
