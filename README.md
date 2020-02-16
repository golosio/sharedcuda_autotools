# sharedcuda_autotools
Example of autotool configuration for building a CUDA shared library

This is a complete working example of autotools configuration for building a shared library. The main problem with implementing a CUDA Shared library is that all the .cu files must be compiled and linked in a single step, without producing the .o files, by directly generating the library without having to link separate files. This also serves to the nvcc compiler to make efficient use of the cuda device functions by compiling them as online functions when possible.
However this possibility is not contemplated by Automake. A possible workaround is to generate first the src/Makefile.in file using autotools, then applying a patch to this file before the make command. Here I apply this patch using a script launched at the end of the config.

You can adapt this example to your need by placing all .cu and .cpp files in the src folder, and replacing the string "sharedcuda" with the name of your library in all files where this string appears.
Just be careful, you should not delete the dummyfile.cpp file, is a dummy file that does nothing, but it is part of the trick!
