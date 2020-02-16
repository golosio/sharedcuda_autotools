//
// A simple function that generates an array with the integers from 0 to n-1
// and call a CUDA function to square all the elements

#include "cudasquare.h"

int *squaredsequence(int n)
{
  int *seq = new int[n];
  for (int i=0; i<n; i++) {
    seq[i] = i;
  }
  int *seq2 = square(seq, n);
  
  return seq2;
}
