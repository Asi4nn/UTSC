#include <iostream>
#include <vector>
#include <numeric>
#include <string.h>
using namespace std;

int main() {
    // ----------------------------- EXAMPLE 1 -----------------------------
    // Define a list of numbers
    vector<int> numbers = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
    int sum;

    // Fold the list of numbers to sum all numbers
    sum = accumulate(numbers.begin(), numbers.end(), 0);

    // print the sum
    std::cout << sum << std::endl;
    // ----------------------------- EXAMPLE 2 -----------------------------

    // Define a list of strings
    vector<string> names = {"John", "Paul", "George", "Ringo"};
    string names_concat;

    // Fold the list of strings over a custom function to concatenate all strings
    names_concat = accumulate(next(names.begin()), names.end(), names[0], [](string a, string b) {
        return a + " " + b;
    });
    
    // print the concatenated names
    std::cout << names_concat << std::endl;
    
    return 0;
}