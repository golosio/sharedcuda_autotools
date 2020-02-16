# sharedcudaexample
Complete simple example of implementation of a CUDA / C++ shared library with Makefile for nvcc / c++

A frequent question from people interested in CUDA/C++ integration is how to write a Makefile for a CUDA/C++ shared library. Since I have spent some time myself to find a good way for doing it, I decided to share my experience and to build this repository with a simple but complete working example. The shared library contains a very simple C++ function "squaredsequence" that generates an array with the integer numbers from 0 to n, and then it calls another C++ function "square" that uses a CUDA kernel "square_kernel" to square all elements of the array. The library can be compiled by the make command:
make
that should produce the shared library file libsharedcuda.so in the lib folder.
As an example of use of this library, in the example folder there is a very simple C++ program that calls the squaredsequence function with n=10 and print the result on the terminal.
This example can be compiled by executing the script:
./make.sh
before executing it, you have to make sure that the folder containing the library is included in the environment variable LD_LIBRARY_PATH. The run.sh script take care of this and executes the example.
