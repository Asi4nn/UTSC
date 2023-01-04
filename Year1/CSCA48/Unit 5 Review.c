#include <stdio.h>
#include <stdlib.h>

// Ex 0

typedef struct BST_struct
{
    int item;
    struct BST_struct *left;
    struct BST_struct *right;
} BST_Node;

typedef struct linked_list_struct
{
    int item;
    struct linked_list_struct *next;
} List_Node;

// Perform in-order traversal without recursion
void in_order_loop(BST_Node *head)
{
    return;
}

// Ex 6
// recursive sum func

int Sum(int arr[], int n)
{
    if (n == 1)
    {
        return arr[0];
    }
    else
    {
        return arr[n-1] + Sum(arr, n-1);
    }
}

// Ex 7

// recursive factorial func
int factorial(int n)
{
    if (n == 1)
    {
        return 1;
    }
    else
    {
        return n * factorial(n-1);
    }
}

// recursive fibonacci
int fib(int n)
{
    if (n == 0 || n == 1)
    {
        return 1;
    }
    else
    {
        return fib(n-1) + fib(n-2);
    }
}

int main()
{
    // Ex 6
    int int_arr[] = {1, 2, 3, 4};
    int sum;
    sum = Sum(int_arr, 4);
    printf("Ex 6: %d\n", sum);

    // Ex 7
    int fib7 = fib(1);
    printf("Ex 7: %d\n", fib7);
}
