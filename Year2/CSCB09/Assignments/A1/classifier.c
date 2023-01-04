#include "knn.h"

/**
 * Compilation command
 *    gcc -Wall -std=c99 -lm -o classifier classifier.c knn.c
 *
 * Decompress dataset into individual images:
 *    tar xvzf datasets.tgz
 *
 * Running quick test with 1k training and 1k testing images, K = 1:
 *    ./classifier 1 lists/training_1k.txt lists/testing_1k.txt
 *
 * Running full evaulation with all images, K = 7: (Will take a while)
 *    ./classifier 7 lists/training_full.txt lists/testing_full.txt
 */

/*****************************************************************************/
/* Do not add anything outside the main function here. Any core logic other  */
/* than what is described below should go into `knn.c`. You've been warned!  */
/*****************************************************************************/

/**
 * main() takes in 3 command line arguments:
 *    - K : The K value for K nearest neighbours 
 *    - training_list: Name of a text file with paths to the training images
 *    - testing_list:  Name of a text file with paths to the testing images
 *
 * You need to do the following:
 *    - Parse the command line arguments, call `load_dataset()` appropriately.
 *    - For each test image, call `knn_predict()` and compare with real label
 *    - Print out (only) one integer to stdout representing the number of 
 *        test images that were correctly predicted.
 *    - Free all the data allocated and exit.
 */
int main(int argc, char *argv[]) {

    // TODO: Handle command line arguments
    if (argc != 4) {
        fprintf(stderr, "Usage: K training_file testing_file");
        exit(1);
    }

    int k = strtol(argv[1], NULL, 10);
    const char *train = argv[2];
    const char *test = argv[3];

    Dataset *training = load_dataset(train);
    Dataset *testing = load_dataset(test);

    // TODO: Compute the total number of correct predictions
    int total_correct = 0;

    for (int i = 0; i < testing->num_items; i++)
    {
        // printf("%d\n", i);
        if (knn_predict(training, &testing->images[i], k) == testing->labels[i]) {
            total_correct++;
        }
    }

    // Print out answer
    printf("%d\n", total_correct);

    free_dataset(training);
    free_dataset(testing);
    return 0;
}