"""
Tests using TDD
"""

from django.test import SimpleTestCase
from app import calc

# 1. Write the tests for behavior to see in the code
# 2. Test fails
# 3. Write the code so test passes

class CalcTestsUsingTDD(SimpleTestCase):
  """ Test substracting numbers """
  def test_substract_numbers(self):
    res = calc.substract(5, 10)
    self.assertEqual(res, 5)

# TDD approach is refactor the code further so improve the code
# write tests first and implement the function
# pass the test and improve the code