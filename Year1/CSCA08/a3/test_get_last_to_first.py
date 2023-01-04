"""A3. Test cases for function club_functions.get_last_to_first.
"""

import unittest
import club_functions


class TestGetLastToFirst(unittest.TestCase):
    """Test cases for function club_functions.get_last_to_first.
    """

    def test_00_empty(self):
        param = {}
        actual = club_functions.get_last_to_first(param)
        expected = {}
        msg = "Expected {}, but returned {}".format(expected, actual)
        self.assertEqual(actual, expected, msg)

    def test_01_one_person_one_friend_same_last(self):
        param = {'Clare Dunphy': ['Phil Dunphy']}
        actual = club_functions.get_last_to_first(param)
        expected = {'Dunphy': ['Clare', 'Phil']}
        msg = "Expected {}, but returned {}".format(expected, actual)
        self.assertEqual(actual, expected, msg)

    def test_02_one_person_one_friend_differnent_last(self):
        param = {'Clare Dunphy': ['Phil Smith']}
        actual = club_functions.get_last_to_first(param)
        expected = {'Dunphy': ['Clare'], 'Smith': ['Phil']}
        msg = "Expected {}, but returned {}".format(expected, actual)
        self.assertEqual(actual, expected, msg)

    def test_03_same_friend(self):
        param = {'Clare Dunphy': ['Phil Smith'],
                'Leo Wang': ['Phil Smith']}
        actual = club_functions.get_last_to_first(param)
        expected = {'Wang': ['Leo'], 'Dunphy': ['Clare'], 'Smith': ['Phil']}
        msg = "Expected {}, but returned {}".format(expected, actual)
        self.assertEqual(actual, expected, msg)

    def test_04_two_friends(self):
        param = {'Jason Kwan': ['Leo Wang'],
                'Leo Wang': ['Jason Kwan']}
        actual = club_functions.get_last_to_first(param)
        expected = {'Wang': ['Leo'], 'Kwan': ['Jason']}
        msg = "Expected {}, but returned {}".format(expected, actual)
        self.assertEqual(actual, expected, msg)

    def test_05_mutation(self):
        arg_dict = {'Clare Dunphy': ['Phil Dunphy']}
        club_functions.get_last_to_first(arg_dict)
        exp_dict = {'Clare Dunphy': ['Phil Dunphy']}
        msg = "Expected {}, but returned {}".format(exp_dict, arg_dict)
        self.assertEqual(arg_dict, exp_dict, msg)

if __name__ == '__main__':
    unittest.main(exit=False)
