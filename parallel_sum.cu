
#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <stdio.h>
#include <stdlib.h>

#include "common.h"
#include "cuda_common.cuh"

__global__ void sum_array_gpu(int* a, int* b, int* c, int size) {
	int gid = threadIdx.x + blockIdx.x * blockDim.x;

	if (gid < size) {
		c[gid] = a[gid] + b[gid];
	}
}

void sum_array_cpu(int* a, int* b, int* c, int size) {
	for (int i = 0; i < size; ++i) {
		c[i] = a[i] + b[i];
	}
}

//int main() {
//	
//	const int array_size = 10000;
//	int array_byte_size = array_size * sizeof(int);
//	const int block_size = 128;
//
//	int* h_a, *h_b, *h_c, *gpu_results;
//	h_a = (int *) malloc(array_byte_size);
//	h_b = (int *) malloc(array_byte_size);
//	h_c = (int *) malloc(array_byte_size);
//	gpu_results = (int *) malloc(array_byte_size);
//
//	for (int i = 0; i < array_size; ++i) {
//		h_a[i] = i;
//		h_b[i] = 2 * i;
//	}
//
//	sum_array_cpu(h_a, h_b, h_c, array_size);
//
//	int* d_a, * d_b, * d_c;
//
//
//	gpuErrCheck(cudaMalloc((void**)&d_a, array_byte_size));
//	gpuErrCheck(cudaMalloc((void**)&d_b, array_byte_size));
//	gpuErrCheck(cudaMalloc((void**)&d_c, array_byte_size));
//
//	cudaMemcpy(d_a, h_a, array_byte_size, cudaMemcpyHostToDevice);
//	cudaMemcpy(d_b, h_b, array_byte_size, cudaMemcpyHostToDevice);
//
//
//	dim3 block(block_size);
//	dim3 grid(array_size / block_size + 1);
//
//	sum_array_gpu << <grid, block >> > (d_a, d_b, d_c, array_size);
//
//	cudaDeviceSynchronize();
//
//	cudaMemcpy(gpu_results, d_c, array_byte_size, cudaMemcpyDeviceToHost);
//
//	int same_res = compare_two_arrays(h_c, gpu_results, array_size);
//
//	if (same_res) {
//		printf("Same Results");
//	} else {
//		printf("Different Results");
//	}
//
//
//	cudaFree(d_a);
//	cudaFree(d_b);
//	cudaFree(d_c);
//	free(h_a);
//	free(h_b);
//	free(h_c);
//	free(gpu_results);
//
//	cudaDeviceReset();
//
//	return 0;
//
//}
