/**
 *                        Min-Heaps
 * 
 * Please make sure you read the blurb in `minheap.h` to ensure you understand 
 * how we are implementing min-heaps here and what assumptions / requirements 
 * are being made.
 * 
 * (c) Mustafa Quraish, 2021
 */

#include "minheap.h"
#include <math.h>

/**
 * Allocate a new min heap of the given size.
 * 
 * TODO: 
 *  Allocate memory for the `MinHeap` object, and the 2 arrays inside it.
 *  `numItems` should initially be set to 0, and all the indices should be
 *   set to -1 to start with (since we don't have anything in the heap).
 */
MinHeap *newMinHeap(int size) {
    MinHeap *e = malloc(sizeof(MinHeap));
    e->numItems = 0;
    e->maxSize = size;
    e->arr = calloc(size, sizeof(HeapElement));
    e->indices = calloc(size, sizeof(int));
    
    for (int i = 0; i < size; i++) {
        e->indices[i] = -1;
    }

    return e;
}

/**
 * Swaps elements at indices `a` and `b` in the heap, and also updates their
 * indices. Assumes that `a` and `b` are valid.
 * 
 * NOTE: This is already implemented for you, no need to change anything.
 */
void swap(MinHeap *heap, int a, int b) {
  // Swap the elements
  HeapElement temp = heap->arr[a];
  heap->arr[a] = heap->arr[b];
  heap->arr[b] = temp;

  // Refresh their indices
  heap->indices[heap->arr[a].val] = a;
  heap->indices[heap->arr[b].val] = b;
}

/**
 * Add a value with the given priority into the heap.
 * 
 * TODO: Complete this function, and make sure all the relevant data is updated
 *      correctly, including the `indices` array if you move elements around. 
 *      Make sure the heap property is not violated. 
 * 
 * You may assume the value does not already exist in the heap, and there is
 * enough space in the heap for it.
 */
void perculate(MinHeap *heap, int index) {
    while (heap->arr[(int)floor((double)(index + 1)/2) - 1].priority > heap->arr[index].priority && index > 0) {
        swap(heap, index, (int)floor((double)(index + 1)/2) - 1);
        index = (int)floor((double)(index + 1)/2) - 1;
    }
}

void heapPush(MinHeap *heap, int val, double priority) {
    heap->numItems += 1;
    HeapElement *element = malloc(sizeof(HeapElement));
    element->priority = priority;
    element->val = val;
    heap->arr[heap->numItems - 1] = *element;
    heap->indices[val] = heap->numItems - 1;

    perculate(heap, heap->numItems - 1);
    // int index = heap->numItems - 1;
    // while (heap->arr[(int)floor((double)index/2)].priority > heap->arr[index].priority && index >= 0) {
    //     swap(heap, index, (int)floor((double)index/2));
    //     index = (int)floor((double)index/2);
    // }
}

/**
 * Extract and return the value from the heap with the minimum priority. Store
 *  the priority for this value in `*priority`. 
 * 
 * For example, if `10` was the value with the lowest priority of `1.0`, then
 *  you would have something that is equivalent to:
 *      
 *        *priority = 1.0;
 *        return 10;
 * 
 * TODO: Complete this function, and make sure all the relevant data is updated
 *      correctly, including the `indices` array if you move elements around. 
 *      Make sure the heap property is not violated. 
 * 
 * You may assume there is at least 1 value in the heap.
 */
void heapify(MinHeap *heap, int index) {
    while ((index + 1) * 2 <= heap->numItems) {
        // if there is only 1 child of the current element
        if ((index + 1) * 2 == heap->numItems) {
            if (heap->arr[(index + 1) * 2 - 1].priority < heap->arr[index].priority) {
                swap(heap, index, (index + 1) * 2 - 1);
            }    
            break;
        }
        else if (heap->arr[(index + 1) * 2 - 1].priority < heap->arr[index].priority || 
                heap->arr[(index + 1) * 2].priority < heap->arr[index].priority) {
            if (heap->arr[(index + 1) * 2 - 1].priority < heap->arr[(index + 1) * 2].priority) {
                swap(heap, index, (index + 1) * 2 - 1);
                index = (index + 1) * 2 - 1;
            }
            else {
                swap(heap, index, (index + 1) * 2);
                index = (index + 1) * 2;
            }
        }
        else {
            break;
        }
    }
}

int heapExtractMin(MinHeap *heap, double *priority) {
    *priority = heap->arr[0].priority;  // Set correct priority  
    int val = heap->arr[0].val;

    // swap root node and lowest priority node
    swap(heap, 0, heap->numItems - 1);
    // free(&heap->arr[heap->numItems - 1]);
    heap->numItems--;

    heapify(heap, 0);

    return val;         // Return correct value
}

/**
 * Decrease the priority of the given value (already in the heap) with the
 * new priority.
 * 
 * NOTE: You will find it helpful here to first get the index of the value
 *       in the heap from the `indices` array.
 * 
 * TODO: Complete this function, and make sure all the relevant data is updated
 *      correctly, including the `indices` array if you move elements around. 
 *      Make sure the heap property is not violated. 
 * 
 * You may assume the value is already in the heap, and the new priority is
 *  smaller than the old one (caller is responsible for ensuring this).
 */
void heapDecreasePriority(MinHeap *heap, int val, double priority) {
    int index = heap->indices[val];

    heap->arr[index].priority = priority;

    perculate(heap, index);
}

/**
 * Free the data for the heap. This won't be marked, but it is always good
 * practice to free up after yourself when using a language like C.
 */
void freeHeap(MinHeap *heap) {
    free(heap->indices);
    for (int i = 0; i < heap->maxSize; i++) {
        free(&heap->arr[i]);
    }
    free(heap->arr);
    free(heap);
}
