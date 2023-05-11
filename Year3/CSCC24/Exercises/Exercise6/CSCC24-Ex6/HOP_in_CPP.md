# Brief Introduction to C++
## What is C++?
<ul>
<li>C++ is a general-purpose programming language.</li>
<li>C++ is a superset of the C programming language.</li>
<li>C++ is a statically typed and compiled language.</li>
<li>C++ is a multi-paradigm language.</li>
<ul>
    <li>C++ supports procedural programming</li>
    <li>C++ supports object-oriented programming</li>
    <li>C++ supports generics through templates.</li>
    <li>C++ supports functional programming through lambda functions</li>
</ul>
</ul>

## Lists in C++
Some standard ways to define a list in C++ are:
```cpp
// Using arrays.
int numbers[10] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}; // fixed size

// Using vectors.
#include <vector>
std::vector<int> numbers = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}; // dynamic size
```

## Iterators in C++
In C++, **iterators** provide an interface to access/modify the elements of a container.<sup>[[1]](#filter)</sup> <br />
Consider the following code which uses iterators to print the elements of a list.
```cpp
#include <iostream>
#include <iterator>
#include <vector>
using namespace std;

int main() {
    // Define a list of numbers
    vector<int> numbers = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
    vector<int> :: iterator it; // Define an iterator to iterate over the list of numbers

    // Print the list of numbers using begin() and end() functions
    for (it = numbers.begin(); it != numbers.end(); it++) {
        cout << *it << " "; // '*' is used as an accessor to get the value of the element pointed by the iterator
    }

    return 0;
}
```
The method `begin()` is used to get the iterator pointing to the first element of the list. <br />
The method `end()` is used to get the iterator pointing to the "after-last" element of the list.

# Higher-Order-Procedures in C++

## Introduction
Unlike functional languages like Racket or Haskell, C++ does not treat functions like first class objects, but there are still many features in the <functional> library which provide many functional features with special syntax and many higher order procedures which functional languages provide.

## Lambda functions in C++
Lambda functions in C++ are defined by the following syntax:
```
[closure](parameters) -> return_type { function_body };
```
### Closure
You can specify variables as a list to be available to the function body in the closure. You can also choose how to pass these variables in, either by prefixing the variable with `&` to pass by reference or without to pass by value.

#### Examples
Using closure passing by value.
```cpp
int x = 42;
auto closure = [x]() -> int { return x; };
// closure() == 42
```
Using closure passing by reference.
```cpp
int x = 42;
auto closure = [&x]() -> int { x += 1; };
closure();
// x == 43
```
### Parameters
Defining parameters is the same as in normal C++ functions, using the type then name syntax.

```cpp
function<int(int, int)> addOne = [](int x) -> int { return x + 1; };
// addOne(6) == 7
```
If there are no parameters we can omit the empty parentheses:
```cpp
auto noParam = [] { return "no params"; };
```
Notice that omitting the parameters also omits the return type, this is doable only by using the `auto` keyword to not require to assign a type to the lambda expression.


## Map in C++

The equivalent of map in C++ is `transform` from the `<algorithm>` library.<sup>[[2]](#filter)</sup>

### As a UnaryOperation

Like many functional languages provide, you can use `transform` to apply a unary operation on every item in a list with the following syntax:
```
transform(Iterator start, Iterator end, Iterator output, UnaryOperator unary_op)
```
Where `start` and `end` are pointers to the start and end points you want to iterate through, `output` is a list to output the result of the operation, and `unary_op` is, as expected, a unary operation that can be applied to every element in the list.

A simple example of adding 1 to each element of an integer array is below, notice that we use the same input and output array to simply overwrite the original, essentially using the operation in place:
```cpp
int arr[] = {1, 2, 3, 4, 5};
auto addOne = [](int x) { return x + 1; };
int n = sizeof(arr) / sizeof(arr[0]); // length of arr

transform(arr, arr + n, arr, addOne);
// 2, 3, 4, 5, 6
for (int i = 0; i < n; i++) {
    cout << arr[i] << "\n";
}
```

### As a Binary Operation

You can also apply a binary operation on two arrays with the following override:
```
transform(Iterator arr1_start, Iterator arr1_end, Iterator arr2_start, Iterator output, BinaryOperator binary_op)
```

Here's an example of adding the elements of two arrays together and placing the result into the first array:

```cpp
int arr1[] = {1, 2, 3};
int arr2[] = {4, 5, 6};
int n1 = sizeof(arr1) / sizeof(arr1[0]);
auto add = [](int x, int y) { return x + y; };

transform(arr1, arr1 + n1, arr2, arr1, add);
// 5, 7, 9
for (int i = 0; i < n1; i++)
{
    cout << arr1[i] << "\n";
}
```

## Filter in C++
A natural way to filter a list in C++ is to use `std::copy_if`.<sup>[[3]](#filter)</sup>
```cpp
OutputIterator copy_if (InputIterator first, InputIterator last,OutputIterator result, UnaryPredicate pred)
```
The function `copy_if` copies the elements in the range `[first, last)` for which `pred` returns `true` to the position pointed by `result`. <br />

### Integer List
The following code shows how to use `std::copy_if` from `<algorithm>` to filter a list of `int`.
```cpp
#include <iostream>
#include <vector>
#include <algorithm>
using namespace std;

int main() {
    // Define a list of numbers
    vector<int> numbers = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
    vector<int> even_numbers;

    // Filter the list of numbers to keep only even numbers
    copy_if(numbers.begin(), numbers.end(), back_inserter(even_numbers), [](int n) {
        return n % 2 == 0;
    });
    
    // printing the even numbers...

    return 0;
}
```
In the above code, we used `std::copy_if` to copy the elements of `numbers` to
`even_numbers` if the element is even. <br />
Specifically, we used `std::back_inserter` (a variation of `std::inserter`)<sup>[[1]](#filter)</sup> to insert the elements to the end of `even_numbers` as we filter
through `numbers`.

### String List
The following code shows how to use `std::copy_if` from `<algorithm>` to filter a list of `string`.
```cpp
#include <iostream>
#include <vector>
#include <algorithm>
using namespace std;

int main() {
    // Define a list of strings
    vector<string> names = {"John", "Paul", "George", "Ringo"};
    vector<string> names_len_lte_four; // names with length less than or equal to 4

    // Filter the list of strings to keep only names with length less than or equal to 4
    copy_if(names.begin(), names.end(), back_inserter(names_len_lte_four), [](string name) {
        return name.length() <= 4;
    });

    // print the filtered names...
    
    return 0;
}
```

## Fold in C++
Folding in C++ can be done using various ways, but here we will focus on 
`std::accumulate`.<sup>[[4]](#filter)</sup> <br />
``` 
T accumulate(InputIt first, InputIt last, T init);
```
Where `T` is the type of the elements in the range `[first, last)` and `init` is the initial value of the accumulator. <br />

An overload of `std::accumulate` that takes a binary operation as a third parameter also exists:
```
T accumulate(InputIt first, InputIt last, T init, BinaryOperation op);
```
Where `op` is a binary operation that is applied to the accumulator and the current element we are iterating over.

### Sum of a List of Integers
The default behavior of `std::accumulate` is to sum the elements of a list.
```cpp
// Define a list of numbers
vector<int> numbers = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
int sum;

// Fold the list of numbers to sum all numbers
sum = accumulate(numbers.begin(), numbers.end(), 0);

// print the sum...
```
This is equivalent to the left fold:
```scheme
((((((((((0 + 1) + 2) + 3) + 4) + 5) + 6) + 7) + 8) + 9) + 10)
```

### Concatenation of a List of Strings
We can also pass in our own lambda function to `std::accumulate` to perform a custom operation like concatenation.
```cpp
// Define a list of strings
    vector<string> names = {"John", "Paul", "George", "Ringo"};
    string names_concat;

    // Fold the list of strings over a custom function to concatenate all strings
    names_concat = accumulate(next(names.begin()), names.end(), names[0], [](string a, string b) {
        return a + " " + b;
    });
    
    // print the concatenated names...
```
This is equivalent to the left fold:
```scheme
((("John" + " " + "Paul") + " " + "George") + " " + "Ringo")
```

## Conclusion
In this article, we learned about various higher-order procedures in C++ and how to use them. We presented 
several ways to use lambda functions and demonstrated some equivalencies of map, filter and fold in C++. <br /> <br />
Please note that C++ is a highly complex and powerful language, and there are many ways to achieve the same result.
We've only shown a few of them here. <br /> <br />
**Thank you for reading!**

## References
<ul>
<li><a name="filter">[1]</a>: https://www.geeksforgeeks.org/iterators-c-stl/</li>
<li><a name="filter">[2]</a>: https://en.cppreference.com/w/cpp/algorithm/transform</li>
<li><a name="filter">[3]</a>: https://cplusplus.com/reference/algorithm/copy_if/</li>
<li><a name="filter">[4]</a>: https://en.cppreference.com/w/cpp/algorithm/accumulate</li>
</ul>
