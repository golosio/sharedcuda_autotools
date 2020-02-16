//
// A simple function that squares all the elements of an array
// through a call to a CUDA kernel
//

#include "cudasquare.cuh"

// Square function kernel
// It squares all the elements of an array
// Arguments:
// a: array that must be squared in the GPU
// b: squared int array (output)
// n: number of elements of the array
__global__
void square_kernel(int *a, int *b, int n) {
  int i = threadIdx.x + blockIdx.x * blockDim.x;
  if (i<n) {
    int val=a[i];
    b[i] = val*val;
  }
}

// Square function
// Arguments:
// ha: array that must be squared in the CPU
// ('h' stands for 'host'.)
// n: number of elements of the array
// Return value: squared int array
int *square(int *ha, int n)
{
  // Create result int arrays on the CPU.
  int *hb = new int[n];

  // Create corresponding int arrays on the GPU.
  // ('d' stands for 'device'.)
  int *da, *db;
  cudaMalloc(&da, n*sizeof(int));
  cudaMalloc(&db, n*sizeof(int));

  // Copy input data from array on CPU to array on GPU.
  cudaMemcpy(da, ha, n*sizeof(int), cudaMemcpyHostToDevice);

  // Launch GPU code with n threads, one per
  // array element.
  square_kernel<<<(n+1023)/1024, 1024>>>(da, db, n);

  // Copy output array from GPU back to CPU.
  cudaMemcpy(hb, db, n*sizeof(int), cudaMemcpyDeviceToHost);

  // Free up the arrays on the GPU.
  cudaFree(da);
  cudaFree(db);

  //return as output the resulting array
  return hb;
}
