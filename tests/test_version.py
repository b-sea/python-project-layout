import importlib_metadata
import unittest

import python_project


class TestVersion(unittest.TestCase):
    def test_version(self):
        self.assertEqual(python_project.__version__, importlib_metadata.version(python_project.__name__))
