
CC=gcc
CXX=g++
NVIDIAC=nvcc
OPENCL=/usr/local/cuda-8.0/include/
CFLAGS=-Xptxas -O3 -D_FILE_OFFSET_BITS=64 -D_LARGEFILE64_SOURCE #-DVERBOSE
BIN=.

all: index_kmers_split_dyn_mat

index_kmers_split_dyn_mat: index_kmers_split_dyn_mat.cu
	$(NVIDIAC) $(CFLAGS) index_kmers_split_dyn_mat.cu kernels.cu -o $(BIN)/index_kmers_split_dyn_mat

clean:
	rm -rf $(BIN)/index_kmers $(BIN)/index_kmers_split_dyn_mat