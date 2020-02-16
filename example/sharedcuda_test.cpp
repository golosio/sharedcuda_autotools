//
// simple example of program using the CUDA shared library 
//
#include <iostream>
#include "sharedcuda.h"

int main()
{
  int n = 10;
  std::cout << "Simple example of program using the CUDA shared library\n"; 
  std::cout << "Use the cuda shared library to square all integers ";
  std::cout << "from 0 to " << n << "\n";
  int *seq2 = squaredsequence(n);

  for (int i=0; i<n; i++) {
    std::cout << i << "\t" << seq2[i] << "\n";
  }

  return 0;
}
