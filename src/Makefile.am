NVCC=nvcc
COMPILER_FLAGS= -O3 -Wall -fPIC
CUDA_FLAGS= -arch sm_30 --ptxas-options=-v --relocatable-device-code true
CUDA_LIBS= -lm
CUDA_LDFLAGS = -shared   # linking flags

.cu.o:
	$(NVCC) -o $@ -c $< $(NVCCFLAGS)

CXXLD=$(NVCC)

lib_LTLIBRARIES = libsharedcuda.la
libsharedcuda_la_SOURCES = dummyfile.cpp
libsharedcuda_la_LDFLAGS = $(CUDA_LDFLAGS)
libsharedcuda_la_CFLAGS = $(CUDA_FLAGS) $(COMPILER_FLAGS)
libsharedcuda_la_LIBADD = $(CUDA_LIBS)
