"""A3. Test cases for function club_functions.get_average_club_count.
"""

import unittest
import club_functions


class TestGetAverageClubCount(unittest.TestCase):
    """Test cases for function club_functions.get_average_club_count.
    """

    def test_00_empty(self):
        param = {}
        actual = club_functions.get_average_club_count(param)
        expected = 0.0
        msg = "Expected {}, but returned {}".format(expected, actual)
        self.assertAlmostEqual(actual, expected, msg=msg)

    def test_01_one_person_one_club(self):
        param = {'Claire Dunphy': ['Parent Teacher Association']}
        actual = club_functions.get_average_club_count(param)
        expected = 1.0
        msg = "Expected {}, but returned {}".format(expected, actual)
        self.assertAlmostEqual(actual, expected, msg=msg)

    def test_02_one_person_no_clubs(self):
        param = {'Claire Dunphy': []}
        actual = club_functions.get_average_club_count(param)
        expected = 0.0
        msg = "Expected {}, but returned {}".format(expected, actual)
        self.assertAlmostEqual(actual, expected, msg=msg)

    def test_03_some_people_some_clubs(self):
        param = {'Michelle Tanner': [],
               'Danny R Tanner': ['Parent Council'],
               'Kimmy Gibbler': ['Rock N Rollers'],
               'Jesse Katsopolis': [],
               'Joey Gladstone': ['Comics R Us', 'Parent Council']}
        actual = club_functions.get_average_club_count(param)
        expected = 0.8
        msg = "Expected {}, but returned {}".format(expected, actual)
        self.assertAlmostEqual(actual, expected, msg=msg)

if __name__ == '__main__':
    unittest.main(exit=False)
