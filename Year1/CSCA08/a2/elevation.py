"""Assignment 2 functions."""

from typing import List


THREE_BY_THREE = [[1, 2, 1],
                  [4, 6, 5],
                  [7, 8, 9]]

FOUR_BY_FOUR = [[1, 2, 6, 5],
                [4, 5, 3, 2],
                [7, 9, 8, 1],
                [1, 2, 1, 4]]

UNIQUE_3X3 = [[1, 2, 3],
              [9, 8, 7],
              [4, 5, 6]]

UNIQUE_4X4 = [[10, 2, 3, 30],
              [9, 8, 7, 11],
              [4, 5, 6, 12],
              [13, 14, 15, 16]]


def compare_elevations_within_row(elevation_map: List[List[int]], map_row: int,
                                  level: int) -> List[int]:
    """Return a new list containing the three counts: the number of
    elevations from row number map_row of elevation map elevation_map
    that are less than, equal to, and greater than elevation level.

    Precondition: elevation_map is a valid elevation map.
                  0 <= map_row < len(elevation_map).

    >>> compare_elevations_within_row(THREE_BY_THREE, 1, 5)
    [1, 1, 1]
    >>> compare_elevations_within_row(FOUR_BY_FOUR, 1, 2)
    [0, 1, 3]

    """

    less = 0
    more = 0
    for elevation in elevation_map[map_row]:
        if elevation < level:
            less += 1
        elif elevation > level:
            more += 1

    return [less, elevation_map[map_row].count(level), more]


def update_elevation(elevation_map: List[List[int]], start: List[int],
                     stop: List[int], delta: int) -> None:
    """Modify elevation map elevation_map so that the elevation of each
    cell between cells start and stop, inclusive, changes by amount
    delta.

    Precondition: elevation_map is a valid elevation map.
                  start and stop are valid cells in elevation_map.
                  start and stop are in the same row or column or both.
                  If start and stop are in the same row,
                      start's column <=  stop's column.
                  If start and stop are in the same column,
                      start's row <=  stop's row.
                  elevation_map[i, j] + delta >= 1
                      for each cell [i, j] that will change.

    >>> THREE_BY_THREE_COPY = [[1, 2, 1],
    ...                        [4, 6, 5],
    ...                        [7, 8, 9]]
    >>> update_elevation(THREE_BY_THREE_COPY, [1, 0], [1, 1], -2)
    >>> THREE_BY_THREE_COPY
    [[1, 2, 1], [2, 4, 5], [7, 8, 9]]
    >>> FOUR_BY_FOUR_COPY = [[1, 2, 6, 5],
    ...                      [4, 5, 3, 2],
    ...                      [7, 9, 8, 1],
    ...                      [1, 2, 1, 4]]
    >>> update_elevation(FOUR_BY_FOUR_COPY, [1, 2], [3, 2], 1)
    >>> FOUR_BY_FOUR_COPY
    [[1, 2, 6, 5], [4, 5, 4, 2], [7, 9, 9, 1], [1, 2, 2, 4]]

    """

    for row in range(len(elevation_map)):
        for col in range(len(elevation_map)):
            if start[0] <= row <= stop[0]:
                if start[1] <= col <= stop[1]:
                    elevation_map[row][col] += delta


def get_average_elevation(elevation_map: List[List[int]]) -> float:
    """Return the average elevation across all cells in the elevation map
    elevation_map.

    Precondition: elevation_map is a valid elevation map.

    >>> get_average_elevation(UNIQUE_3X3)
    5.0
    >>> get_average_elevation(FOUR_BY_FOUR)
    3.8125
    """

    sum = 0
    for row in elevation_map:
        for elevation in row:
            sum += elevation

    return sum / len(elevation_map) ** 2


def find_peak(elevation_map: List[List[int]]) -> List[int]:
    """Return the cell that is the highest point in the elevation map
    elevation_map.

    Precondition: elevation_map is a valid elevation map.
                  Every elevation value in elevation_map is unique.

    >>> find_peak(UNIQUE_3X3)
    [1, 0]
    >>> find_peak(UNIQUE_4X4)
    [0, 3]
    """

    peak = [0, 0]
    for i in range(len(elevation_map)):
        for i2 in range(len(elevation_map[i])):
            if elevation_map[i][i2] > elevation_map[peak[0]][peak[1]]:
                peak = [i, i2]

    return peak


def is_sink(elevation_map: List[List[int]], cell: List[int]) -> bool:
    """Return True if and only if cell exists in the elevation map
    elevation_map and cell is a sink.

    Precondition: elevation_map is a valid elevation map.
                  cell is a 2-element list.

    >>> is_sink(THREE_BY_THREE, [0, 5])
    False
    >>> is_sink(THREE_BY_THREE, [0, 2])
    True
    >>> is_sink(THREE_BY_THREE, [1, 1])
    False
    >>> is_sink(FOUR_BY_FOUR, [2, 3])
    True
    >>> is_sink(FOUR_BY_FOUR, [3, 2])
    True
    >>> is_sink(FOUR_BY_FOUR, [1, 3])
    False
    """

    if cell[0] >= len(elevation_map) or cell[1] >= len(elevation_map):
        return False

    for i in range(len(elevation_map)):
        if cell[0] - 1 <= i <= cell[0] + 1:
            for i2 in range(len(elevation_map[i])):
                if (cell[1] - 1 <= i2 <= cell[1] + 1 and elevation_map[i][i2] <
                        elevation_map[cell[0]][cell[1]]):
                    return False
    return True


def find_local_sink(elevation_map: List[List[int]],
                    cell: List[int]) -> List[int]:
    """Return the local sink of cell cell in elevation map elevation_map.

    Precondition: elevation_map is a valid elevation map.
                  elevation_map contains no duplicate elevation values.
                  cell is a valid cell in elevation_map.

    >>> find_local_sink(UNIQUE_3X3, [1, 1])
    [0, 0]
    >>> find_local_sink(UNIQUE_3X3, [2, 0])
    [2, 0]
    >>> find_local_sink(UNIQUE_4X4, [1, 3])
    [0, 2]
    >>> find_local_sink(UNIQUE_4X4, [2, 2])
    [2, 1]
    """

    if is_sink(elevation_map, cell):
        return cell

    sink = cell[:]

    for i in range(len(elevation_map)):
        if cell[0] - 1 <= i <= cell[0] + 1:
            for i2 in range(len(elevation_map[i])):
                if (cell[1] - 1 <= i2 <= cell[1] + 1 and
                        elevation_map[sink[0]][sink[1]] >
                        elevation_map[i][i2]):
                    sink = [i, i2]
    return sink


def can_hike_to(elevation_map: List[List[int]], start: List[int],
                dest: List[int], supplies: int) -> bool:
    """Return True if and only if a hiker can go from start to dest in
    elevation_map without running out of supplies.

    Precondition: elevation_map is a valid elevation map.
                  start and dest are valid cells in elevation_map.
                  dest is North-West of start.
                  supplies >= 0

    >>> map = [[1, 6, 5, 6],
    ...        [2, 5, 6, 8],
    ...        [7, 2, 8, 1],
    ...        [4, 4, 7, 3]]
    >>> can_hike_to(map, [3, 3], [2, 2], 10)
    True
    >>> can_hike_to(map, [3, 3], [2, 2], 8)
    False
    >>> can_hike_to(map, [3, 3], [3, 0], 7)
    True
    >>> can_hike_to(map, [3, 3], [3, 0], 6)
    False
    >>> can_hike_to(map, [3, 3], [0, 0], 18)
    True
    >>> can_hike_to(map, [3, 3], [0, 0], 17)
    False

    """

    pos = start[:]

    while supplies >= 0 and pos != dest:
        if pos[0] == dest[0]:
            supplies -= abs(elevation_map[pos[0]][pos[1]] -
                            elevation_map[pos[0]][pos[1] - 1])
            pos[1] -= 1
        elif pos[1] == dest[1]:
            supplies -= abs(elevation_map[pos[0]][pos[1]] -
                            elevation_map[pos[0] - 1][pos[1]])
            pos[0] -= 1
        # elif below checks if the difference in elevation between going North
        # is less than or equal to the difference in elevation going West
        elif abs(elevation_map[pos[0]][pos[1]] -
                 elevation_map[pos[0] - 1][pos[1]]) <= abs(
                     elevation_map[pos[0]][pos[1]] -
                     elevation_map[pos[0]][pos[1] - 1]):
            supplies -= abs(elevation_map[pos[0]][pos[1]] -
                            elevation_map[pos[0] - 1][pos[1]])
            pos[0] -= 1
        else:
            supplies -= abs(elevation_map[pos[0]][pos[1]] -
                            elevation_map[pos[0]][pos[1] - 1])
            pos[1] -= 1

    if supplies < 0:
        return False
    return True


def get_lower_resolution(elevation_map: List[List[int]]) -> List[List[int]]:
    """Return a new elevation map, which is constructed from the values
    of elevation_map by decreasing the number of elevation points
    within it.

    Precondition: elevation_map is a valid elevation map.

    >>> get_lower_resolution(
    ...     [[1, 6, 5, 6],
    ...      [2, 5, 6, 8],
    ...      [7, 2, 8, 1],
    ...      [4, 4, 7, 3]])
    [[3, 6], [4, 4]]
    >>> get_lower_resolution(
    ...     [[7, 9, 1],
    ...      [4, 2, 1],
    ...      [3, 2, 3]])
    [[5, 1], [2, 3]]

    """

    new_map = []

    for r in range(0, len(elevation_map), 2):
        row = []
        for c in range(0, len(elevation_map), 2):
            if r + 1 == len(elevation_map) and c + 1 == len(elevation_map):
                avg = elevation_map[r][c]
            elif r + 1 == len(elevation_map):
                avg = (elevation_map[r][c] + elevation_map[r][c + 1])//2
            elif c + 1 == len(elevation_map):
                avg = (elevation_map[r][c] + elevation_map[r + 1][c])//2
            else:
                avg = (elevation_map[r][c] + elevation_map[r + 1][c] +
                       elevation_map[r][c + 1] +
                       elevation_map[r + 1][c + 1])//4
            row.append(avg)
        new_map.append(row)

    return new_map
