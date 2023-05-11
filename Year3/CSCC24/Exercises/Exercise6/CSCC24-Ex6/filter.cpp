#include <iostream>
#include <vector>
#include <algorithm>
#include <string.h>
using namespace std;

int main() {
    // ----------------------------- EXAMPLE 1 -----------------------------
    // Define a list of numbers
    vector<int> numbers = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
    vector<int> even_numbers;

    // Filter the list of numbers to keep only even numbers
    copy_if(numbers.begin(), numbers.end(), back_inserter(even_numbers), [](int n) {
        return n % 2 == 0;
    });
    
    // print the filtered numbers
    for (int n : even_numbers) {
        std::cout << n << " ";
    }
    std::cout << std::endl;

    // ----------------------------- EXAMPLE 2 -----------------------------

    // Define a list of strings
    vector<string> names = {"John", "Paul", "George", "Ringo"};
    vector<string> names_len_lte_four; // names with length less than or equal to 4

    // Filter the list of strings to keep only names with length less than or equal to 4
    copy_if(names.begin(), names.end(), back_inserter(names_len_lte_four), [](string name) {
        return name.length() <= 4;
    });

    // print the filtered names
    for (string name : names_len_lte_four) {
        std::cout << name << " ";
    }
    std::cout << std::endl;
    
    return 0;
}