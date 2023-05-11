# Guide: Pandas DataFrame `to_expr` Function

The `to_expr` function is a method in the frame.py file within the core module of the Pandas Python library. It is used to convert a DataFrame object into a string representation that can be used to reconstruct the DataFrame later. The function has the following signature:

```
DataFrame.to_expr(base_expr=False) -> str
```

### Parameters

- `base_expr` (bool, default=False): If set to True, the resulting string will exclude the name and indexing of the DataFrame.

### Returns
`str`: The string that can be used to reconstruct the DataFrame.

### Examples
Here are some examples of using the to_expr function:
```
import pandas as pd

# Create a DataFrame
df = pd.DataFrame({'column_1': pd.Series([1, 2, 3], dtype='int64'),
                   'column_2': pd.Series([1.0, 2.0, 3.0], dtype='float64')})

# Convert DataFrame to expression string
expr_string = df.to_expr()

# Print the expression string
print(expr_string)
# Output: "pd.DataFrame({'column_1': pd.Series([1, 2, 3], dtype='int64'), 'column_2': pd.Series([1.0, 2.0, 3.0], dtype='float64')})"

# Create a DataFrame with custom index
df2 = pd.DataFrame({'apples': [3, 2, 0, 1], 'oranges': [0, 3, 7, 2]},
                   index=["Jan", "Feb", "Mar", "Apr"])

# Convert DataFrame to expression string with custom index
expr_string2 = df2.to_expr()

# Print the expression string
print(expr_string2)
# Output: "pd.DataFrame({'apples': pd.Series([3, 2, 0, 1], dtype='int64'), 'oranges': pd.Series([0, 3, 7, 2], dtype='int64')}, index=['Jan', 'Feb', 'Mar', 'Apr'])"
```
