#include <stdio.h>
#include <stdlib.h>
#include <string.h>

 // temp
#include <time.h>
#include "closest.c"

int main() {
  srand(time(NULL));

  AVLNode* root = NULL;
  //int length = 3;
  //int vals[] = { 0,-500, 17 };
  //int vals[11] = { 0,-5,-26,-3,15,10,9,5,2,56,13 };
  //int vals[11] = { 100, 200, 140 };
  //int vals[5] = { 0,-5,10,-26,-3/*,5,15,2,9,13,58 */ };
  //int vals[11] = { 0,-5,10,-3,0,0,0,0,0,0 };
  /*int vals[8] = { 100, 200, 140, 130, 195, 154, 102, 155 };
  for (int i = 0; i < 8; i++)
    root = insert(root, vals[i]);*/

  int number_list[16];
  for (int i = 0; i < 16; i++) {
    int random_number = rand() % 1000;
    root = insert(root, random_number);
  }

  int a = 0;
  int b = 0;
  int c = 0;
  int d = 0;
  int difference = 0;
  int smallest = 10000;

  populateArray(number_list, root);

  for (int i = 1; i < 16;i++) {
    difference = abs(number_list[i - 1] - number_list[i]);
    if (difference < smallest) {
      smallest = difference;
      a = number_list[i - 1];
      b = number_list[i];
    }
  }

  printf("Actual: %d %d\n\n", a, b);

  closestPair(root, &c, &d);
  printf("Predicted: %d %d\n", a, b);

  /*root = insert(root, 0);
  root = insert(root, -5);
  root = insert(root, -6);
  root = insert(root, -4);
  root = insert(root, 15);
  root = insert(root, 10);
  root = insert(root, 7);
  root = insert(root, 5);
  root = insert(root, 2);
  root = insert(root, 16);
  root = insert(root, 14);
  root = insert(root, 1);*/ // ! double rotate test!

}

int j = 0;
void populateArray(int* arr, AVLNode* root) {
  if (root == NULL) {
    return;
  }

  populateArray(arr, root->left);
  arr[j] = root->value;
  j++;
  populateArray(arr, root->right);
}