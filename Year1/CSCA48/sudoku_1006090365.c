/*
 * CSC A48 - Exercise 11 - Sudoku Solver
 *
 * Your goal in this exercise is to practice recursion and
 * to see how a properly written recursive solution can
 * take care of fairly complicated tasks with a few lines
 * of (well thought out) code.
 *
 * We will be solving Sudoku puzzles. In case you have never
 * solved or seen a Sudoku, you can learn more about them
 * here:
 *
 * https://en.wikipedia.org/wiki/Sudoku
 *
 * Your task if to write a function that takes an input
 * Sudoku in the form of a 9x9 array of integers. the
 * array will have a few entries filled with numbers in
 * [1, 9], and the remaining entries set to zero.
 *
 * For the example in the wiki, the input array will
 * be
 *
 * 5 3 0 0 7 0 0 0 0
 * 6 0 0 1 9 5 0 0 0
 * 0 9 8 0 0 0 0 6 0
 * 8 0 0 0 6 0 0 0 3
 * 4 0 0 8 0 3 0 0 1
 * 7 0 0 0 2 0 0 0 6
 * 0 6 0 0 0 0 2 8 0
 * 0 0 0 4 1 9 0 0 5
 * 0 0 0 0 8 0 0 7 9
 *
 * Your code should find the values that correctly
 * complete the Sudoku.
 *
 * As a brief reminder, a correctly solved Sudoku is
 * one in which there are no repeated digits in any
 * row, any column, or any of the 3x3 sub-arrays that
 * make up the large 9x9 grid. Another way to think
 * about it is, every row, column, and 3x3 subgrid
 * uses all of the different digits.
 *
 * How to solve this?
 *
 * * RECURSIVELY!
 *
 * (hint) - Solving a Sudoku with N unknown values
 * may involve trying something, then solving an
 * easier Sudoku problem.
 *
 * * How to approach this?
 *
 * - As noted in class:
 * 	a) Determine the base case(s)
 * 	b) Figure out the recursive case
 * 	c) Determine what needs to happen to
 * 	   the solution for the entire problem
 * 	   is returned once the recursion hits
 * 	   the base case(s)
 *
 * - Conditions on the input Sudoku
 * 	- It will have AT LEAST ONE DIGIT in each
 * 	  3x3 subgrid. Likely there will be several
 * 	  3x3 subgrids with several digits already
 * 	  set to some value.
 *
 * - Conditions on your solution
 * 	- It should return a solution if there
 * 	  exists one.
 * 	- If no solution can be found, return the
 * 	  original input array
 * 	- If multiple solutions exist, any one of
 *        them is valid
 *
 * - Can I use helper functions?
 * 	- Yes, by all means!
 *
 * - Can I add extra libraries?
 * 	- No, they won't be needed.
 *
 * - Can I change the 'print_sudoku()' function?
 * 	- Please don't, we may need it for testing!
 *
 * (c) F. Estrada, March 2019
 */

#include<stdio.h>
#include<stdlib.h>
#include<string.h>

void print_sudoku(int sudoku[9][9])
{
  printf("The Sudoku contains:\n");
  for (int j=0; j<9; j++)
  {
    for (int i=0; i<9;i++)
    {
      printf("%d  ",sudoku[j][i]);
    }
    printf("\n");
  }
}

int check_sudoku(int sudoku[9][9])
{
  /*
   *  This function checks whether a Sudoku is properly
   * solved. That means that each row, column, and
   * 3x3 subgrid uses each digit only once.
   *
   *  If *ignores* zeros, so you can use it to check
   * that a partial solution is valid
   */

  /*****
   * TO DO:
   * Complete this function
   *   -- BUT ONLY IF YOU WANT TO!
   * Our testing script only checks your Sudoku
   * solution, if you want to solve it without
   * using this function, or if you want to write
   * your own helper functions, that's ok!
   * *****/
    for (int i = 1; i <= 9; i++)
    {
        // check if every row or col does not have more than one of each number
        for (int j = 0; j < 9; j++)
        {
            int row_counter = 0;
            int col_counter = 0;
            for (int k = 0; k < 9; k++)
            {
                if (sudoku[j][k] == i)
                {
                    row_counter++;
                    //printf("row i: %d j: %d k: %d \n", i, j, k);
                }
                if (sudoku[k][j] == i)
                {
                    col_counter++;
                    //printf("col i: %d j: %d k: %d \n", i, j, k);
                }
                if (row_counter == 2 || col_counter == 2)
                {
                    return 0;
                }
            }
        }

        //check if every 3x3 box does not have more than one of each nunber
        for (int j = 0; j < 3; j++)
        {
            for (int k = 0; k < 3; k++)
            {
                int box_counter = 0;
                for (int l = 0; l < 3; l++)
                {
                    for (int n = 0; n < 3; n++)
                    {
                        if (sudoku[3*j + l][3*k + n] == i)
                        {
                            box_counter++;
                        }
                        if (box_counter == 2)
                        {
                            return 0;
                        }
                    }
                }
            }
        }
    }

    // passed all tests so it must be valid
    return 1;
}

int solved(int sudoku[9][9])
{
  /*
   * This function checks whether a given Sudoku is
   * completely solved (it has no zeros, all digits
   * are used once per row, column, and sub-grid.
   * It returns 1 if the Sudoku is solved, zero
   * otherwise
   */

  /*****
   * TO DO
   * Complete this function
   * BUT ONLY IF YOU WANT TO!
   *   You can solve the Sudoku without using this function,
   * or you can write a different helper function, whatever
   * makes more sense to yoU! our checker won't look at this
   * function,
   * ****/
    if (check_sudoku(sudoku) == 1)
    {
        for (int i = 0; i < 9; i++)
        {
            for (int j = 0; j < 9; j++)
            {
                if (sudoku[i][j] == 0)
                {
                    return 0;
                }
            }
        }
        return 1;
    }
    return 0;
}

void copy_sudoku (int sudoku[9][9], int copy_sudoku[9][9])
{
    for (int i = 0; i < 9; i++)
    {
        for (int j = 0; j < 9; j++)
        {
            copy_sudoku[i][j] = sudoku[i][j];
        }
    }
}

void solve_sudoku(int sudoku[9][9], int depth)
{
  /*
   * This function solves an input Sudoku, the
   * input has a value of 0 for any entries that
   * are not yet decided. If no solution exists
   * the function returns the input array *exactly
   * as it was* when the function was called.
   *
   * The 'depth' parameter is provided in case you
   * want to use it to help debug and trace your
   * code. You do not need to use it if you don't
   * want to, and the problem can be solved without
   * using the depth value at all.
   *
   * The automated checker won't look at the depth
   * either.
   */

  /*****
   * TO DO:
   * Complete this function
   *****/
   //printf("%d\n", depth);

    int i = 0;
    int j = 0;

    while (sudoku[i][j] != 0)
    {
        j++;
        if (j == 9)
        {
            i++;
            j = 0;
        }
        if (i == 9)
        {
            return;
        }
    }

    int copy[9][9];


    for (int input = 1; input <= 9; input++)
    {
        copy_sudoku(sudoku, copy);
        copy[i][j] = input;
        //printf("%d\n", check_sudoku(sudoku));
        if (check_sudoku(sudoku) == 1)
        {
            if (solved(copy))
            {
                copy_sudoku(copy, sudoku);
                return;
            }
            else
            {
                solve_sudoku(copy, depth + 1);
                if (solved(copy))
                {
                    copy_sudoku(copy, sudoku);
                    return;
                }
            }
        }
        else
        {
            sudoku[i][j] = 0;
        }
    }

    return;
}

#ifndef __testing

int main()
{
   // We'll provide you with the same test case
   // from the Wiki, so you can check your output.
   // But as always, be aware we will test your
   // solution on different Sudoku puzzles.
   /*
   int Sudoku[9][9]={{5, 3, 0, 0, 7, 0, 0, 0, 0},
		     {6, 0, 0, 1, 9, 5, 0, 0, 0},
		     {0, 9, 8, 0, 0, 0, 0, 6, 0},
		     {8, 0, 0, 0, 6, 0, 0, 0, 3},
		     {4, 0, 0, 8, 0, 3, 0, 0, 1},
		     {7, 0, 0, 0, 2, 0, 0, 0, 6},
		     {0, 6, 0, 0, 0, 0, 2, 8, 0},
		     {0, 0, 0, 4, 1, 9, 0, 0, 5},
		     {0, 0, 0, 0, 8, 0, 0, 7, 9}};


    */

    int Sudoku[9][9]={{0, 0, 0, 0, 0, 0, 0, 0, 0},
            {0, 0, 0, 0, 0, 0, 0, 0, 0},
            {0, 0, 0, 0, 0, 0, 0, 0, 0},
            {0, 0, 0, 0, 0, 0, 0, 0, 0},
            {0, 0, 0, 0, 0, 0, 0, 0, 0},
            {0, 0, 0, 0, 0, 0, 0, 0, 0},
            {0, 0, 0, 0, 0, 0, 0, 0, 0},
            {0, 0, 0, 0, 0, 0, 0, 0, 0},
            {0, 0, 0, 0, 0, 0, 0, 0, 0}};

  printf("Input puzzle is:\n");
  print_sudoku(Sudoku);

  solve_sudoku(Sudoku,0);

  printf("Solution is:\n");
  print_sudoku(Sudoku);

}

#endif
