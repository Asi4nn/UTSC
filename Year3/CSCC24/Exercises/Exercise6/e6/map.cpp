#include <algorithm>
#include <iostream>

using namespace std;

int main()
{
    int arr[] = {1, 2, 3, 4, 5};
    auto addOne = [](int x) { return x + 1; };
    int n = sizeof(arr) / sizeof(arr[0]); // length of arr

    transform(arr, arr + n, arr, addOne);

    // 2, 3, 4, 5, 6
    for (int i = 0; i < n; i++) {
        cout << arr[i] << "\n";
    }

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
}