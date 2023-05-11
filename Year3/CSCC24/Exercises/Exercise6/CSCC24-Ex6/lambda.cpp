#include <functional>
#include <iostream>

using namespace std;

int main() {
    // parameter
    function<int(int)> addOne = [](int x) -> int { return x + 1; };
    // addOne(6) == 7
    cout << "addOne:" << addOne(6) << '\n';

    // omit parameter list
    auto noParam = [] { return "no params"; };
    // noParam() == "no params"
    cout << noParam() << '\n';

    // closure 
    int x = 42;
    auto closure = [x]() -> int { return x; };
    closure();
    // closure() == 42
    cout << "closure:" << x << '\n';

    // closure with reference
    int x1 = 42;
    auto closure_reference = [&x1]() -> int
    { x1 += 1; };
    closure_reference();
    // x == 43
    cout << "closure reference:" << x1 << '\n';
}