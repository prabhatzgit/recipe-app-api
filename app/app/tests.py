"""
Sample tests
"""

# for no database integration, use SimpleTestCase
from django.test import SimpleTestCase
from app import calc

class CalcTests(SimpleTestCase):
  """ Test the calc module"""
  def test_add_numbers(self):
    """ Test adding numbers together. """
    res = calc.add(5, 6)
    # positive scenario
    self.assertEqual(res, 11)
    # negative scenario
    # self.assertEqual(res, 12)

# run the Django managed API test command docker-compose run --rm app sh -c "python manage.py test" 
# to run the tests in the terminal
# run: run the service
# --rm: remove the container once it's finished running so we don't have to clean up after it  