"""Review: some simple exercises on recursion. Use Python3.10.  Please
implement ALL of the following RECURSIVELY.  Otherwise it defeats the
purpose of this lab --- we need to freshen up on our recursion skills.

You have until Friday 6p.m. to submit your work on MarkUs.

For full marks, this and every other piece of Python code you submit
must pass flake8 and pylint. See course website for required versions
of the software.

"""


def length(lst: list) -> int:
    """Return the number of elements (top level) in lst.

    >>> length([1, 2, 3, 4, 5, 6])
    6
    >>> length([])
    0
    """
    if not lst:
        return 0
    return 1 + length(lst[1:])


def reverse(lst: list) -> list:
    """Return the reverse of lst.

    >>> reverse([1, 2, 3, 4, 5, 6])
    [6, 5, 4, 3, 2, 1]
    >>> reverse([])
    []
    """
    if not lst:
        return lst
    return [lst[-1]] + reverse(lst[:-1])


def is_pal(lst: list) -> bool:
    """Return whether lst is a palindrome.

    For fun, do not use an if-statement.

    >>> is_pal([1, 2, 3, 4, 5, 6])
    False
    >>> is_pal([14, 244, 3133, 244, 14])
    True
    >>> is_pal([])
    True
    """

    return len(lst) <= 1 or lst[0] == lst[-1] and is_pal(lst[1:-1])


def num_el(lst: list) -> int:
    """Return the number of (non-list) elements of lst, on any nesting
    level.

    >>> num_el([14, 244, 3133, 244, 14])
    5
    >>> num_el([[1, 2, 3], 4, [5, 6], [7, [8, 9]]])
    9
    >>> num_el([[[[]]]])
    0
    """
    if not lst:
        return 0

    if isinstance(lst[0], list):
        num = num_el(lst[0])
    else:
        num = 1
    return num + num_el(lst[1:])


def sum_els(lst: list) -> int:
    """Return the sum of all numbers in lst, on any nesting level. Return
    0 on an empty list.

    >>> sum_els([[1, 2, 3], 4, [5, 6], [7, [8, 9]]])
    45
    >>> sum_els([[[[]]]])
    0
    """
    if not lst:
        return 0

    if isinstance(lst[0], list):
        return sum_els(lst[0]) + sum_els(lst[1:])

    return lst[0] + sum_els(lst[1:])


def repeat_twice(lst: list) -> list:
    """Return a list of elements of lst, each repeated twice, in the same
    order as they appear in lst.

    >>> repeat_twice(['c', '2', '4'])
    ['c', 'c', '2', '2', '4', '4']
    >>> repeat_twice([])
    []
    """
    if not lst:
        return []

    repeated = [lst[0]] * 2
    return repeated + repeat_twice(lst[1:])


def my_filter(func: callable, lst: list) -> list:
    """Return a list of those elements from lst that pass the function
    func (i.e., func(x) is True for element x in lst), in their
    original order.

    func is a boolean-valued function applicable to every element of
    lst.

    >>> my_filter(lambda x: x % 2 == 0, [1, 2, 3, 4, 5, 6])
    [2, 4, 6]
    """

    if not lst:
        return []

    if func(lst[0]):
        return [lst[0]] + my_filter(func, lst[1:])
    return my_filter(func, lst[1:])


def my_map(func: callable, lst: list) -> list:
    """Return a list of results of applying func to each element of lst.

    func is applicable to every element of lst.

    >>> my_map(lambda x: x * 2, [1, 2, 3, 4, 5, 6])
    [2, 4, 6, 8, 10, 12]
    """
    if not lst:
        return []

    return [func(lst[0])] + my_map(func, lst[1:])


# Optional.
def reverse_linear(lst: list) -> list:
    """Return the reverse of lst, in linear time.

    >>> reverse([1, 2, 3, 4, 5, 6])
    [6, 5, 4, 3, 2, 1]
    >>> reverse([])
    []
    """

    if not lst:
        return []
    first = lst[0]
    temp = reverse(lst[:-1])
    temp.append(first)
    return temp


if __name__ == '__main__':
    import doctest
    doctest.testmod()
