import unittest
import pytest

from app import util


@pytest.mark.unit
class TestUtil(unittest.TestCase):
    def test_convert_to_int_correct_param(self):
        self.assertEqual(4, util.convert_to_int("4"))
        self.assertEqual(0, util.convert_to_int("0"))
        self.assertEqual(0, util.convert_to_int("-0"))
        self.assertEqual(-1, util.convert_to_int("-1"))
        self.assertAlmostEqual(4.0, util.convert_to_int("4.0"), delta=0.0000001)
        self.assertAlmostEqual(0.0, util.convert_to_int("0.0"), delta=0.0000001)
        self.assertAlmostEqual(0.0, util.convert_to_int("-0.0"), delta=0.0000001)
        self.assertAlmostEqual(-1.0, util.convert_to_int("-1.0"), delta=0.0000001)

    def test_convert_to_int_invalid_type(self):
        self.assertRaises(TypeError, util.convert_to_int, "")
        self.assertRaises(TypeError, util.convert_to_int, "s")
        self.assertRaises(TypeError, util.convert_to_int, None)
        self.assertRaises(TypeError, util.convert_to_int, object())
