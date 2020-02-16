# sharedcuda_autotools
Example of autotool configuration for building a CUDA shared library

This is a complete working example of autotools configuration for building a shared library. The shared library contains a very simple C++ function "squaredsequence" that generates an array with the integer numbers from 0 to n, and then it calls another C++ function "square" that uses a CUDA kernel "square_kernel" to square all elements of the array. The library can be compiled in the usual way:

./configure
make
sudo make install

that should produce the shared library file libsharedcuda.so and install it a proper folder. If you are using debian/ubuntu, after installation you should also run

sudo ldconfig

As an example of use of this library, in the example folder there is a very simple C++ program that calls the squaredsequence function with n=10 and print the result on the terminal. This example can be compiled by executing the script:
./make.sh

You can adapt this library to your need by placing all .cu and .cpp files in the src folder, and replacing the string "sharedcuda" with the name of your library in all files where this string appears.
Just be careful, you should not delete the dummyfile.cpp file, is a dummy file that does nothing, but it is part of the trick!

The main problem with implementing a CUDA Shared library is that all the .cu files must be compiled and linked in a single step, without producing the .o files, by directly generating the library without having to link separate files. This also serves to the nvcc compiler to make efficient use of the cuda device functions by compiling them as online functions when possible.
However the possibility of compiling and linking more files in a single step is not contemplated by Automake. A possible workaround is to generate first the src/Makefile.in file using autotools, then applying a patch to this file before the make command. Here I apply this patch using a script launched at the end of the config.
Tested on ubuntu 18.04 with  automake-1.15 and autoconf 2.69-11
With other versions you might have to adapt the script patch.sh,
or modify by hand the file src/Makefile.in after running "./configure".
The relevant line is:
    $(AM_V_CXXLD)$(libsharedcuda_la_LINK) ...
that should be replaced by something like:
    $(NVCC) -ccbin=${CXX} --compiler-options  "${COMPILER_FLAGS}" ${CUDA_FLAGS} ${CUDA_LDFLAGS} -o libsharedcuda.so source-files $(CUDA_LIBS)
 where source-files is the list of files to be compiled.
 Be careful: the line is preceded by a tab, not by spaces.
 If you want to be able to use "make install", you should also modify the command that installs the library in the proper folder. In my case in:
    $(LIBTOOL) $(AM_LIBTOOLFLAGS) $(LIBTOOLFLAGS) --mode=install $(INSTALL) $(INSTALL_STRIP_FLAG) $$list2 "$(DESTDIR)$(libdir)";

"$$list2" should be replaced by "libsharedcuda.so"
