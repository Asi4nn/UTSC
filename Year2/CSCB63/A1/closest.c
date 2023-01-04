/************************************************************************
 *                       CSCB63 Winter 2021
 *                  Assignment 1 - AVL Trees
 *                  (c) Mustafa Quraish, Jan. 2021
 *
 * This is the file which should be completed and submitted by you
 * for the assignment. Make sure you have read all the comments
 * and understood what exactly you are supposed to do before you
 * begin. A few test cases are provided in `testClosest.c`, which
 * can be run on the command line as follows:
 *
 *  $> gcc testClosest.c -o testClosest
 *  $> ./testClosest [optional testname]  (or .\testClosest.exe if on Windows)
 *
 * I strongly advise that you write more test cases yourself to see
 * if you have expected behaviour, especially on the edge cases for
 * insert(). You are free to make any reasonable design choices for
 * the implementation of the data structure as long as (1) the outputs
 * are consistent with the expected results, and (2) you meet the
 * complexity requirement. Your closestPair() function will only
 * be tested with cases where there are unique solutions.
 *
 * Mark Breakdown (out of 10):
 *  - 0 marks if the code does not pass at least 1 test case.
 *  - If the code passes at least one test case, then:
 *    - Up to 6 marks for successfully passing all the test cases
 *    - Up to 4 marks for meeting the complexity requirements for 
 *        the functions as described in the comments below.
 *
 ************************************************************************/

#include <stdio.h>
#include <stdlib.h>

/**
 * This defines the struct(ure) used to define the nodes
 * for the AVL tree we are going to use for this
 * assignment. You need to add some more fields here to be
 * able to complete the functions in order to meet the
 * complexity requirements
 */
typedef struct avl_node {
  // Stores the value (key) of this node
  int value;
  int height;
  int *a;
  int *b;

  // Pointers to the children
  struct avl_node *left;
  struct avl_node *right;

  // TODO: Add the other fields you need here to complete the assignment!
  //      (Hint: You need at least 1 more field to keep balance)

} AVLNode;;

/**
 * This function allocates memory for a new node, and initializes it. 
 * The allocation is already completed for you, in case you haven't used C 
 * before. For future assignments this will be up to you!
 * 
 * TODO: Initialize the new fields you have added
 */
AVLNode *newNode(int value) {

  AVLNode *node = calloc(sizeof(AVLNode), 1);
  if (node == NULL) {  // In case there's an error
    return NULL;
  }

  node->value = value;
  node->left = NULL;
  node->right = NULL;

  // Initialize values of the new fields here...
  node->a = NULL;
  node->b = NULL;
  node->height = 1;
  return node;
}

/**
 * This function is supposed to insert a new node with the give value into the 
 * tree rooted at `root` (a valid AVL tree, or NULL)
 *
 *  NOTE: `value` is a positive integer in the range 1 - 1,000,000 (inclusive)
 *       The upper bound here only exists to potentially help make the 
 *                implementation of edge cases easier.
 *
 *  TODO:
 *  - Make a node with the value and insert it into the tree
 *  - Make sure the tree is balanced (AVL property is satisfied)
 *  - Return the *head* of the new tree (A balance might change this!)
 *  - Make sure the function runs in O(log(n)) time (n = number of nodes)
 * 
 * If the value is already in the tree, do nothing and just return the root. 
 * You do not need to print an error message.
 *
 * ----
 * 
 * An example call to this function is given below. Note how the
 * caller is responsible for updating the root of the tree:
 *
 *  AVLNod *root = (... some tree is initialized ...);
 *  root = insert(root, 5); // Update the root!
 */

int max_int(int a, int b)
{
    return (a > b)? a : b;
}

int height(AVLNode *root) {
    if (root == NULL) {
        return 0;
    }

    return root->height;
}

int balance_factor(AVLNode *root) {
    if (root == NULL) {
        return 0;
    }
    return height(root->left) - height(root->right);
}

int successor(AVLNode *root) {
    root = root->right;
    while(root->left != NULL) {
        root = root->left;
    }
    return root->value;
}

int predecessor(AVLNode *root) {
    root = root->left;
    while(root->right != NULL) {
        root = root->right;
    }
    return root->value;
}

void update_closest(AVLNode *root) {
    if (root->left == NULL && root->right == NULL) {
        if (root->a != NULL) {
            free(root->a);
        }
        if (root->b != NULL) {
            free(root->b);
        }
        root->a = NULL;
        root->b = NULL;
        return;
    }
    else {
        if (root->a == NULL) {
            root->a = calloc(sizeof(int), 1);
        }
        if (root->b == NULL) {
            root->b = calloc(sizeof(int), 1);
        }
    }

    if (root->left == NULL) {
        if (root->right->a == NULL) {
            *root->a = root->value;
            *root->b = root->right->value;
        }
        else {
            *root->a = *root->right->a;
            *root->b = *root->right->b;
        }
    }
    else if (root->right == NULL) {
        if (root->left->a == NULL) {
            *root->a = root->left->value;
            *root->b = root->value;
        }
        else {
            *root->a = *root->left->a;
            *root->b = *root->left->b;
        }
    }
    else {
        if (root->left->a == NULL && root->right->a == NULL) {
            if (abs(root->value - root->left->value) <= abs(root->value - root->right->value)) {
                *root->a = root->left->value;
                *root->b = root->value;
            }
            else if (abs(root->value - root->left->value) > abs(root->value - root->right->value)) {
                *root->a = root->value;
                *root->b = root->right->value;
            }
        }
        else if (root->left->a == NULL) {
            if (abs(root->left->value - root->value) <= abs(*root->right->a - *root->right->b)) {
                *root->a = root->left->value;
                *root->b = root->value;
            }
            else {
                *root->a = *root->right->a;
                *root->b = *root->right->b;
            }
        }
        else if (root->right->a == NULL) {
            if (abs(*root->left->a - *root->left->b) <= abs(root->right->value - root->value)) {
                *root->a = *root->left->a;
                *root->b = *root->left->b;
            }
            else {
                *root->a = root->value;
                *root->b = root->right->value;
            }
        }
        else {
            if (abs(*root->left->a - *root->left->b) <= abs(*root->right->a - *root->right->b)) {
                *root->a = *root->left->a;
                *root->b = *root->left->b;
            }
            else {
                *root->a = *root->right->a;
                *root->b = *root->right->b;
            }
        }
    }
}

// Rotation functions

AVLNode *leftRotate(AVLNode *root) {
    AVLNode *right = root->right;
    AVLNode *right_left_subtree = right->left;

    right->left = root;
    root->right = right_left_subtree;

    root->height = max_int(height(root->left), height(root->right)) + 1;
    right->height = max_int(height(right->left), height(right->right)) + 1;

    update_closest(root);
    update_closest(right);

    return right;
}

AVLNode *rightRotate(AVLNode *root) {
    AVLNode *left = root->left;
    AVLNode *left_right_subtree = left->right;

    left->right = root;
    root->left = left_right_subtree;

    root->height = max_int(height(root->left), height(root->right)) + 1;
    left->height = max_int(height(left->left), height(left->right)) + 1;

    update_closest(root);
    update_closest(left);

    return left;
}

AVLNode *insert(AVLNode *root, int value) {
    if (root == NULL) {
        return newNode(value);
    }

    if (value < root->value) {
        root->left = insert(root->left, value);
    }
    else if (value > root->value) {
        root->right = insert(root->right, value);
    }
    else {
        return root;
    }

    root->height = max_int(height(root->left), height(root->right)) + 1;
    update_closest(root);

    // printf("balance: %d\n", balance_factor(root));

    // Right rotate
    if (balance_factor(root) > 1) {
        // Account for Left-Right rotation
        if (root->left->value < value) {
            root->left = leftRotate(root->left);
        }
        return rightRotate(root);
    }
    // Left rotate
    else if (balance_factor(root) < -1) {
        // Account for Right-Left rotation
        if (root->right->value > value) {
            root->right = rightRotate(root->right);
        }
        return leftRotate(root);
    }

    return root;
}

/**
 * This function returns the closest pair of points in the tree rooted
 * at `root`. You can assume there are at least 2 values already in the
 * tree. Since you cannot return multiple values in C, for this function
 * we will be using pointers to return the pair. In particular, you need
 * to set the values for the two closest points in the locations pointed
 * to by `a` and `b`. For example, if the closest pair of points is
 * `10` and `11`, your code should have something like this:
 *
 *   (*a) = 10 // This sets the value at the address `a` to 10
 *   (*b) = 11 // This sets the value at the address `b` to 11
 *
 * NOTE: Make sure `(*a)` stores the smaller of the two values, and
 *                 `(*b)` stores the greater of the two values.
 * 
 * NOTE: The test cases will have a unique solution, don't worry about 
 *        multiple closest pairs here.
 *
 *
 * TODO: Complete this function to return the correct closest pair.
 *       Your function should not be any slower than O(log(n)), but if 
 *       you are smart about it you can do it in constant time.
 */
void closestPair(AVLNode *root, int *a, int *b) {
    if (root->a == NULL || root->b == NULL) {
        printf("ERROR: root has NULL closest nodes\n");
        exit(1);
    }
    // printf("a: %d b: %d\n", *root->a, *root->b);
    *a = *root->a;
    *b = *root->b;
}

/******************************************************************************
 * QUERY() and DELETE() are not part for this assignment, but I recommend you
 * try to implement them on your own time to make sure you understand how AVL
 * trees work.
 *
 *                              End of Assignment 1
 *****************************************************************************/
