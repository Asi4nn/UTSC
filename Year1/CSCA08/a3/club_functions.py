"""Assignment 3: Club Recommendations - Starter code."""
from typing import List, Tuple, Dict, TextIO


# Sample Data (Used by Doctring examples)

P2F = {'Jesse Katsopolis': ['Danny R Tanner', 'Joey Gladstone',
                            'Rebecca Donaldson-Katsopolis'],
       'Rebecca Donaldson-Katsopolis': ['Kimmy Gibbler'],
       'Stephanie J Tanner': ['Michelle Tanner', 'Kimmy Gibbler'],
       'Danny R Tanner': ['Jesse Katsopolis', 'DJ Tanner-Fuller',
                          'Joey Gladstone']}

P2C = {'Michelle Tanner': ['Comet Club'],
       'Danny R Tanner': ['Parent Council'],
       'Kimmy Gibbler': ['Rock N Rollers', 'Smash Club'],
       'Jesse Katsopolis': ['Parent Council', 'Rock N Rollers'],
       'Joey Gladstone': ['Comics R Us', 'Parent Council']}


# Helper functions

def update_dict(key: str, value: str,
                key_to_values: Dict[str, List[str]]) -> None:
    """Update key_to_values with key/value. If key is in key_to_values,
    and value is not already in the list associated with key,
    append value to the list. Otherwise, add the pair key/[value] to
    key_to_values.

    >>> d = {'1': ['a', 'b']}
    >>> update_dict('2', 'c', d)
    >>> d == {'1': ['a', 'b'], '2': ['c']}
    True
    >>> update_dict('1', 'c', d)
    >>> d == {'1': ['a', 'b', 'c'], '2': ['c']}
    True
    >>> update_dict('1', 'c', d)
    >>> d == {'1': ['a', 'b', 'c'], '2': ['c']}
    True
    """

    if key not in key_to_values:
        key_to_values[key] = []

    if value not in key_to_values[key]:
        key_to_values[key].append(value)


def split_name(name: str) -> str:
    """Returns a string rearranging name from the form last, first to
    become first last.

    >>> split_name('Wang, Leo')
    >>> 'Leo Wang'
    """
    n = name.split(',')
    return n[1][1:] + ' ' + n[0]


def last_name(name: str) -> str:
    """Returns the last name of name.

    >>> last_name('Leo Wang')
    'Wang'
    """
    return name.split(' ')[-1]


def first_names(name: str) -> str:
    """Returns the first name(s) of name.

    >>> first_names('Leo A Wang')
    ['Leo', 'A']
    """
    return " ".join(name.split(' ')[:-1])


def check_in_persons_club(person_to_clubs: Dict[str, List[str]], member: str,
                          person: str) -> bool:
    """Returns whether member is in any club that person is in, according
    to person_to_clubs.

    >>> P2C = {'a': ['a1', 'a2'], 'b': ['a1', 'b1']}
    >>> check_in_persons_club(person_to_clubs, 'a', 'b')
    True

    >>> P2C = {'a': ['a1', 'a2'], 'b': ['b2', 'b1']}
    >>> check_in_persons_club(person_to_clubs, 'a', 'b')
    False
    """
    for club in person_to_clubs[person]:
        if member in invert_and_sort(person_to_clubs)[club]:
            return True
    return False


# Required functions

def load_profiles(profiles_file: TextIO) -> Tuple[Dict[str, List[str]],
                                                  Dict[str, List[str]]]:
    """Return a two-item tuple containing a "person to friends" dictionary
    and a "person_to_clubs" dictionary with the data from
    profiles_file.

    NOTE: Functions (including helper functions) that have a parameter
          of type TextIO do not need docstring examples.

    """
    person_friend = {}
    person_club = {}
    pc_list = []

    for line in profiles_file:
        if line != "\n":
            pc_list.append(line.strip())
        elif len(pc_list) > 0:
            person = split_name(pc_list[0])
            pc_list.pop(0)
            pc_list.sort()
            for c in pc_list:
                if ',' in c:
                    update_dict(person, split_name(c), person_friend)
                else:
                    update_dict(person, c, person_club)
            pc_list = []

    return (person_friend, person_club)


def get_average_club_count(person_to_clubs: Dict[str, List[str]]) -> float:
    """Return the average number of clubs that a person in person_to_clubs
    belongs to.

    >>> get_average_club_count(P2C)
    1.6

    """
    if len(person_to_clubs) == 0:
        return 0.0

    avg = 0
    for person in person_to_clubs:
        avg += len(person_to_clubs[person])

    return avg / len(person_to_clubs)


def get_last_to_first(
        person_to_friends: Dict[str, List[str]]) -> Dict[str, List[str]]:
    """Return a "last name to first name(s)" dictionary with the people
    from the "person to friends" dictionary person_to_friends.

    >>> get_last_to_first(P2F) == {
    ...    'Katsopolis': ['Jesse'],
    ...    'Tanner': ['Danny R', 'Michelle', 'Stephanie J'],
    ...    'Gladstone': ['Joey'],
    ...    'Donaldson-Katsopolis': ['Rebecca'],
    ...    'Gibbler': ['Kimmy'],
    ...    'Tanner-Fuller': ['DJ']}
    True

    """
    last_to_first = {}

    for person in person_to_friends:
        update_dict(last_name(person), first_names(person), last_to_first)
        for friend in person_to_friends[person]:
            update_dict(last_name(friend), first_names(friend), last_to_first)

    return last_to_first


def invert_and_sort(key_to_value: Dict[object, object]) -> Dict[object, list]:
    """Return key_to_value inverted so that each key is a value (for
    non-list values) or an item from an iterable value, and each value
    is a list of the corresponding keys from key_to_value.  The value
    lists in the returned dict are sorted.

    >>> invert_and_sort(P2C) == {
    ...  'Comet Club': ['Michelle Tanner'],
    ...  'Parent Council': ['Danny R Tanner', 'Jesse Katsopolis',
    ...                     'Joey Gladstone'],
    ...  'Rock N Rollers': ['Jesse Katsopolis', 'Kimmy Gibbler'],
    ...  'Comics R Us': ['Joey Gladstone'],
    ...  'Smash Club': ['Kimmy Gibbler']}
    True

    """
    inverted = {}

    for key in key_to_value:
        if type(key_to_value[key]) == list:
            for item in key_to_value[key]:
                update_dict(item, key, inverted)
        else:
            update_dict(key_to_value[key], key, inverted)

    return inverted


def get_clubs_of_friends(person_to_friends: Dict[str, List[str]],
                         person_to_clubs: Dict[str, List[str]],
                         person: str) -> List[str]:
    """Return a list, sorted in alphabetical order, of the clubs in
    person_to_clubs that person's friends from person_to_friends
    belong to, excluding the clubs that person belongs to. Each club
    appears in the returned list once per each of the person's friends
    who belong to it.

    >>> get_clubs_of_friends(P2F, P2C, 'Danny R Tanner')
    ['Comics R Us', 'Rock N Rollers']

    """
    clubs = []
    if person not in person_to_friends:
        return []

    for friend in person_to_friends[person]:
        if friend in person_to_clubs:
            for club in person_to_clubs[friend]:
                if (person not in person_to_clubs or
                        club not in person_to_clubs[person]):
                    clubs.append(club)
    clubs.sort()

    return clubs


def recommend_clubs(
        person_to_friends: Dict[str, List[str]],
        person_to_clubs: Dict[str, List[str]],
        person: str,) -> List[Tuple[str, int]]:
    """Return a list of club recommendations for person based on the
    "person to friends" dictionary person_to_friends and the "person
    to clubs" dictionary person_to_clubs using the specified
    recommendation system.

    >>> recommend_clubs(P2F, P2C, 'Stephanie J Tanner')
    [('Comet Club', 1), ('Rock N Rollers', 1), ('Smash Club', 1)]

    """
    club_to_points = {}
    for club in invert_and_sort(person_to_clubs):
        club_to_points[club] = 0

    clubs = get_clubs_of_friends(person_to_friends, person_to_clubs, person)

    for club in clubs:
        club_to_points[club] = clubs.count(club)

    for club in invert_and_sort(person_to_clubs):
        if person in person_to_clubs and club not in person_to_clubs[person]:
            for member in invert_and_sort(person_to_clubs)[club]:
                if check_in_persons_club(person_to_clubs, member, person):
                    club_to_points[club] += 1

    recommended_list = []
    for club in club_to_points:
        if club_to_points[club] is not 0:
            recommended_list.append((club, club_to_points[club]))

    return recommended_list


if __name__ == '__main__':
    pass

    # If you add any function calls for testing, put them here.
    # Make sure they are indented, so they are within the if statement body.
    # That includes all calls on print, open, and doctest.

    # import doctest
    # doctest.testmod()
