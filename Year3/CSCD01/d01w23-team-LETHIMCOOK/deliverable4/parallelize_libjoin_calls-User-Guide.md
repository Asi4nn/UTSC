# Guide: Pandas _libs `left_join_indexer` Function

The `left_join_indexer` function is a method in the `join.pyx` file within the `_lib` module 
of the Pandas Python library. It is an internal helper function used to left join two 
numerical arrays and compare indices of the resultant array and input arrays. 

The function has the following signature: 

```
left_join_indexer(ndarray[numeric_object_t] left, ndarray[numeric_object_t] right)
```

### Parameters

- `left` (ndarray[numeric_object_t]): "Left" numeric array.
- `right` (ndarray[numeric_object_t]): "Right" numeric array.

### Returns
- `result` (ndarray): Array containing all elements in `left` and duplicate elements 
in `right` that also exist in `left`.
- `lindexer` (ndarray): Array containing the indices of all `result` elements in `left`.
- `rindexer` (ndarray): Array containing the indices of all `result` elements in `right`.
If the index is not found, use denote as index -1.

### Examples
Here are some examples of using the `left_join_indexer` function:
```
import numpy as np
from pandas._libs import join as libjoin
from threading import Thread

# No multi-threading.

# Declare arrays.
left = np.array([1, 2, 3, 4, 5], dtype=np.int64)
right = np.array([0, 3, 5, 7, 9], dtype=np.int64)

# Call left_join_indexer.
result, lindexer, rindexer = libjoin.left_join_indexer(a, b)

# Print return values.
print(result)
print(lindexer)
print(rindexer)

# Multi-threading (2 threads).

# Declare arrays.
left = np.array([1, 2, 3, 4, 5], dtype=np.int64)
right = np.array([1, 1, 2, 2, 4, 4], dtype=np.int64)

# Index to split the arrays into chunks. Each thread will process a chunk.
aloc = len(a) // 2
bloc = b.searchsorted(a[aloc])

# Array that stores the return value of each thread.
chunk1_result = [[]] * 1
chunk2_result = [[]] * 1

# Helper function that each thread will run.
def thread_left_join_indexer(left, right, result):
    result[0] = libjoin.left_join_indexer(left, right)

# Create threads.
t1 = Thread(target=thread_left_join_indexer, args=(a[:aloc], b[:bloc], chunk1_result))
t2 = Thread(target=thread_left_join_indexer, args=(a[aloc:], b[bloc:], chunk2_result))

# Start and wait for each thread.
t1.start()
t2.start()
t1.join()
t2.join()

# Lindexer and rindexer values for chunk 2.
chunk2_lindexer = np.array(list(map(lambda x: x + aloc, chunk2_result[0][1])))
chunk2_rindexer = np.array(list(map(lambda x: x + bloc if x != -1 else -1, chunk2_result[0][2])))

# Combine return values from each thread to get final result.
combine_result = np.r_[chunk1_result[0][0], chunk2_result[0][0]]
combine_lindexer = np.r_[chunk1_result[0][1], chunk2_lindexer]
combine_rindexer = np.r_[chunk1_result[0][2], chunk2_rindexer]

# Print return values.
print(combine_result)
print(combine_Lindexer)
print(combine_rindexer)
```

**Note:** Similarly, in the same file, we can use `inner_join`, `left_outer_join`, 
`full_outer_join`, `_get_result_indexer`, `left_join_indexer_unique`, `inner_join_indexer`, 
and `outer_join_indexer` like above.