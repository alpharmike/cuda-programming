#include <stdio.h>
#include <stdlib.h>

#include "cuda.h"
#include "cuda_runtime.h"
#include "device_launch_parameters.h"

__global__ void add_matrices(float* c, float* a, float* b, int m, int n) {
	int blockId = blockIdx.x + blockIdx.y * gridDim.x;
	int threadId = blockId * (blockDim.x * blockDim.y) + (threadIdx.y * blockDim.x) + threadIdx.x;

	if (threadId < m * n) {
		c[threadId] = a[threadId] + b[threadId];
	}
}

int main(int argc, char* argv[]) {
	// Set default values for N and M
	int n = 5;
	int m = 5;

	if (argc >= 3) {
		n = atoi(argv[1]);
		m = atoi(argv[2]);

		if (n <= 0 || m <= 0) {
			printf("Positive values should be provided for M and N");
			return EXIT_FAILURE;
		}

	}

	// Initialize matrix size values
	// declare pointers to vectors in host memory
	float* h_mat_a, * h_mat_b, * h_mat_c;
	int mat_size = m * n;
	int mat_size_bytes = mat_size * sizeof(float);

	// Allocate memory for host side matrices
	h_mat_a = (float*)malloc(mat_size_bytes);
	h_mat_b = (float*)malloc(mat_size_bytes);
	h_mat_c = (float*)malloc(mat_size_bytes);

	// Declare device side matrices
	float* d_mat_a, * d_mat_b, * d_mat_c;
	// Allocate memory for device side matrices
	cudaMalloc((void**)&d_mat_a, mat_size_bytes);
	cudaMalloc((void**)&d_mat_b, mat_size_bytes);
	cudaMalloc((void**)&d_mat_c, mat_size_bytes);

	for (int i = 0; i < mat_size; ++i) {
		h_mat_a[i] = i;
		h_mat_b[i] = 10.0 * i;
	}

	cudaMemcpy(d_mat_a, h_mat_a, mat_size_bytes, cudaMemcpyHostToDevice);
	cudaMemcpy(d_mat_b, h_mat_b, mat_size_bytes, cudaMemcpyHostToDevice);

	dim3 block_size(16, 16);
	dim3 num_blocks((n - 1 + block_size.x) / block_size.x,
		(m - 1 + block_size.y) / block_size.y);
	add_matrices << < num_blocks, block_size >> > (d_mat_c, d_mat_a, d_mat_b, m, n);

	cudaMemcpy(h_mat_c, d_mat_c, mat_size_bytes, cudaMemcpyDeviceToHost);

	if (n <= 10) {
		for (int i = 0; i < mat_size; ++i) {
			if (i != 0 && i % m == 0) {
				printf("\n");
			}
			printf("%f ", h_mat_c[i]);
		}
	}


	cudaFree(d_mat_a);
	cudaFree(d_mat_b);
	cudaFree(d_mat_c);
	free(h_mat_a);
	free(h_mat_b);
	free(h_mat_c);

	return 0;
}